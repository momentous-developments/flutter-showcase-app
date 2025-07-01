from fastapi import APIRouter, Query, HTTPException, Depends
from typing import Optional, List
from datetime import datetime, timedelta
import random

from models import (
    KanbanTask, KanbanColumn, KanbanBoard, TaskPriority,
    BaseResponse, PaginatedResponse
)
from utils import generate_mock_tasks, paginate_data, search_data
from .auth import get_current_user

router = APIRouter()

# Mock data
mock_boards = []
mock_columns = []
mock_tasks = generate_mock_tasks()

# Initialize mock boards and columns
def init_mock_boards():
    board_names = ["Development Board", "Marketing Campaign", "Product Launch", "Bug Tracking"]
    column_templates = [
        ["Backlog", "To Do", "In Progress", "Review", "Done"],
        ["Ideas", "Planning", "In Progress", "Complete"],
        ["To Do", "Doing", "Done"],
        ["New", "Assigned", "In Progress", "Testing", "Resolved", "Closed"]
    ]
    
    for i in range(len(board_names)):
        board = {
            "id": i + 1,
            "title": board_names[i],
            "description": f"Board for managing {board_names[i].lower()} tasks",
            "created_at": datetime.now() - timedelta(days=random.randint(30, 180)),
            "updated_at": datetime.now() - timedelta(days=random.randint(0, 30)),
            "members": [
                {"id": j, "name": f"User {j}", "avatar": f"/images/avatars/{j}.png"}
                for j in range(1, random.randint(3, 6))
            ]
        }
        mock_boards.append(board)
        
        # Create columns for this board
        columns = column_templates[i % len(column_templates)]
        for j, col_name in enumerate(columns):
            column = {
                "id": len(mock_columns) + 1,
                "board_id": board["id"],
                "title": col_name,
                "position": j
            }
            mock_columns.append(column)
    
    # Assign tasks to columns
    for task in mock_tasks:
        # Assign to random board and column
        board_id = random.randint(1, len(mock_boards))
        board_columns = [c for c in mock_columns if c["board_id"] == board_id]
        if board_columns:
            column = random.choice(board_columns)
            task["column_id"] = column["id"]
            task["board_id"] = board_id

init_mock_boards()

@router.get("/boards", response_model=PaginatedResponse)
async def get_boards(
    limit: int = Query(10, ge=1, le=100),
    offset: int = Query(0, ge=0),
    search: Optional[str] = None,
    current_user: dict = Depends(get_current_user)
):
    """Get all kanban boards"""
    boards = mock_boards.copy()
    
    # Apply search
    if search:
        boards = search_data(boards, search, ["title", "description"])
    
    # Add task counts
    for board in boards:
        board_tasks = [t for t in mock_tasks if t.get("board_id") == board["id"]]
        board["task_count"] = len(board_tasks)
    
    # Apply pagination
    result = paginate_data(boards, limit, offset)
    
    return PaginatedResponse(
        success=True,
        **result
    )

@router.get("/boards/{board_id}", response_model=KanbanBoard)
async def get_board(
    board_id: int,
    current_user: dict = Depends(get_current_user)
):
    """Get a specific board with all columns and tasks"""
    board = next((b for b in mock_boards if b["id"] == board_id), None)
    if not board:
        raise HTTPException(status_code=404, detail="Board not found")
    
    # Get columns for this board
    board_columns = [c for c in mock_columns if c["board_id"] == board_id]
    board_columns.sort(key=lambda x: x["position"])
    
    # Get tasks for each column
    columns_with_tasks = []
    for column in board_columns:
        column_tasks = [t for t in mock_tasks if t["column_id"] == column["id"]]
        column_with_tasks = {
            **column,
            "tasks": column_tasks
        }
        columns_with_tasks.append(column_with_tasks)
    
    return KanbanBoard(
        **board,
        columns=columns_with_tasks
    )

@router.post("/boards", response_model=KanbanBoard)
async def create_board(
    title: str,
    description: Optional[str] = None,
    column_names: List[str] = ["To Do", "In Progress", "Done"],
    current_user: dict = Depends(get_current_user)
):
    """Create a new kanban board"""
    new_board = {
        "id": len(mock_boards) + 1,
        "title": title,
        "description": description,
        "created_at": datetime.now(),
        "updated_at": datetime.now(),
        "members": [{"id": current_user["id"], "name": current_user["full_name"], "avatar": current_user["avatar"]}]
    }
    mock_boards.append(new_board)
    
    # Create columns
    columns = []
    for i, col_name in enumerate(column_names):
        new_column = {
            "id": len(mock_columns) + 1,
            "board_id": new_board["id"],
            "title": col_name,
            "position": i,
            "tasks": []
        }
        mock_columns.append(new_column)
        columns.append(new_column)
    
    return KanbanBoard(
        **new_board,
        columns=columns
    )

@router.put("/boards/{board_id}", response_model=KanbanBoard)
async def update_board(
    board_id: int,
    title: Optional[str] = None,
    description: Optional[str] = None,
    current_user: dict = Depends(get_current_user)
):
    """Update a board's details"""
    board = next((b for b in mock_boards if b["id"] == board_id), None)
    if not board:
        raise HTTPException(status_code=404, detail="Board not found")
    
    board_index = next((i for i, b in enumerate(mock_boards) if b["id"] == board_id), None)
    if board_index is not None:
        if title:
            mock_boards[board_index]["title"] = title
        if description is not None:
            mock_boards[board_index]["description"] = description
        mock_boards[board_index]["updated_at"] = datetime.now()
        
        return await get_board(board_id, current_user)
    
    raise HTTPException(status_code=500, detail="Failed to update board")

@router.delete("/boards/{board_id}", response_model=BaseResponse)
async def delete_board(
    board_id: int,
    current_user: dict = Depends(get_current_user)
):
    """Delete a board and all its contents"""
    board = next((b for b in mock_boards if b["id"] == board_id), None)
    if not board:
        raise HTTPException(status_code=404, detail="Board not found")
    
    # Remove board
    mock_boards[:] = [b for b in mock_boards if b["id"] != board_id]
    
    # Remove columns
    mock_columns[:] = [c for c in mock_columns if c["board_id"] != board_id]
    
    # Remove tasks
    mock_tasks[:] = [t for t in mock_tasks if t.get("board_id") != board_id]
    
    return BaseResponse(success=True, message="Board deleted successfully")

@router.post("/boards/{board_id}/columns", response_model=KanbanColumn)
async def create_column(
    board_id: int,
    title: str,
    position: Optional[int] = None,
    current_user: dict = Depends(get_current_user)
):
    """Create a new column in a board"""
    board = next((b for b in mock_boards if b["id"] == board_id), None)
    if not board:
        raise HTTPException(status_code=404, detail="Board not found")
    
    # Determine position
    board_columns = [c for c in mock_columns if c["board_id"] == board_id]
    if position is None:
        position = len(board_columns)
    
    # Shift positions if needed
    for col in board_columns:
        if col["position"] >= position:
            col_index = next((i for i, c in enumerate(mock_columns) if c["id"] == col["id"]), None)
            if col_index is not None:
                mock_columns[col_index]["position"] += 1
    
    new_column = {
        "id": len(mock_columns) + 1,
        "board_id": board_id,
        "title": title,
        "position": position,
        "tasks": []
    }
    mock_columns.append(new_column)
    
    return KanbanColumn(**new_column)

@router.put("/columns/{column_id}", response_model=KanbanColumn)
async def update_column(
    column_id: int,
    title: Optional[str] = None,
    position: Optional[int] = None,
    current_user: dict = Depends(get_current_user)
):
    """Update a column"""
    column = next((c for c in mock_columns if c["id"] == column_id), None)
    if not column:
        raise HTTPException(status_code=404, detail="Column not found")
    
    column_index = next((i for i, c in enumerate(mock_columns) if c["id"] == column_id), None)
    if column_index is not None:
        if title:
            mock_columns[column_index]["title"] = title
        
        if position is not None and position != column["position"]:
            # Reorder columns
            board_columns = [c for c in mock_columns if c["board_id"] == column["board_id"]]
            old_position = column["position"]
            
            # Update positions
            for col in board_columns:
                col_idx = next((i for i, c in enumerate(mock_columns) if c["id"] == col["id"]), None)
                if col_idx is not None:
                    if old_position < position:
                        # Moving right
                        if old_position < col["position"] <= position:
                            mock_columns[col_idx]["position"] -= 1
                    else:
                        # Moving left
                        if position <= col["position"] < old_position:
                            mock_columns[col_idx]["position"] += 1
            
            mock_columns[column_index]["position"] = position
        
        # Get tasks for the column
        column_tasks = [t for t in mock_tasks if t["column_id"] == column_id]
        
        return KanbanColumn(
            **mock_columns[column_index],
            tasks=column_tasks
        )
    
    raise HTTPException(status_code=500, detail="Failed to update column")

@router.delete("/columns/{column_id}", response_model=BaseResponse)
async def delete_column(
    column_id: int,
    move_tasks_to: Optional[int] = None,
    current_user: dict = Depends(get_current_user)
):
    """Delete a column"""
    column = next((c for c in mock_columns if c["id"] == column_id), None)
    if not column:
        raise HTTPException(status_code=404, detail="Column not found")
    
    # Move or delete tasks
    column_tasks = [t for t in mock_tasks if t["column_id"] == column_id]
    if move_tasks_to:
        # Verify target column exists and is in the same board
        target_column = next((c for c in mock_columns if c["id"] == move_tasks_to), None)
        if not target_column or target_column["board_id"] != column["board_id"]:
            raise HTTPException(status_code=400, detail="Invalid target column")
        
        # Move tasks
        for task in column_tasks:
            task_index = next((i for i, t in enumerate(mock_tasks) if t["id"] == task["id"]), None)
            if task_index is not None:
                mock_tasks[task_index]["column_id"] = move_tasks_to
    else:
        # Delete tasks
        mock_tasks[:] = [t for t in mock_tasks if t["column_id"] != column_id]
    
    # Remove column
    mock_columns[:] = [c for c in mock_columns if c["id"] != column_id]
    
    # Update positions
    board_columns = [c for c in mock_columns if c["board_id"] == column["board_id"]]
    for col in board_columns:
        if col["position"] > column["position"]:
            col_index = next((i for i, c in enumerate(mock_columns) if c["id"] == col["id"]), None)
            if col_index is not None:
                mock_columns[col_index]["position"] -= 1
    
    return BaseResponse(success=True, message="Column deleted successfully")

@router.post("/tasks", response_model=KanbanTask)
async def create_task(
    title: str,
    column_id: int,
    description: Optional[str] = None,
    assignee_id: Optional[int] = None,
    priority: TaskPriority = TaskPriority.medium,
    due_date: Optional[datetime] = None,
    tags: Optional[List[str]] = None,
    current_user: dict = Depends(get_current_user)
):
    """Create a new task"""
    column = next((c for c in mock_columns if c["id"] == column_id), None)
    if not column:
        raise HTTPException(status_code=404, detail="Column not found")
    
    # Get assignee info
    assignee_name = None
    assignee_avatar = None
    if assignee_id:
        # Mock assignee lookup
        assignee_name = f"User {assignee_id}"
        assignee_avatar = f"/images/avatars/{assignee_id}.png"
    
    new_task = {
        "id": len(mock_tasks) + 1,
        "title": title,
        "description": description,
        "column_id": column_id,
        "board_id": column["board_id"],
        "assignee_id": assignee_id,
        "assignee_name": assignee_name,
        "assignee_avatar": assignee_avatar,
        "priority": priority,
        "due_date": due_date,
        "tags": tags or [],
        "attachments": [],
        "comments_count": 0,
        "created_at": datetime.now(),
        "updated_at": datetime.now()
    }
    
    mock_tasks.append(new_task)
    
    return KanbanTask(**new_task)

@router.put("/tasks/{task_id}", response_model=KanbanTask)
async def update_task(
    task_id: int,
    title: Optional[str] = None,
    description: Optional[str] = None,
    column_id: Optional[int] = None,
    assignee_id: Optional[int] = None,
    priority: Optional[TaskPriority] = None,
    due_date: Optional[datetime] = None,
    tags: Optional[List[str]] = None,
    current_user: dict = Depends(get_current_user)
):
    """Update a task"""
    task = next((t for t in mock_tasks if t["id"] == task_id), None)
    if not task:
        raise HTTPException(status_code=404, detail="Task not found")
    
    task_index = next((i for i, t in enumerate(mock_tasks) if t["id"] == task_id), None)
    if task_index is not None:
        if title:
            mock_tasks[task_index]["title"] = title
        if description is not None:
            mock_tasks[task_index]["description"] = description
        if column_id:
            # Verify column exists
            column = next((c for c in mock_columns if c["id"] == column_id), None)
            if not column:
                raise HTTPException(status_code=400, detail="Invalid column")
            mock_tasks[task_index]["column_id"] = column_id
            mock_tasks[task_index]["board_id"] = column["board_id"]
        if assignee_id is not None:
            if assignee_id == 0:
                # Unassign
                mock_tasks[task_index]["assignee_id"] = None
                mock_tasks[task_index]["assignee_name"] = None
                mock_tasks[task_index]["assignee_avatar"] = None
            else:
                mock_tasks[task_index]["assignee_id"] = assignee_id
                mock_tasks[task_index]["assignee_name"] = f"User {assignee_id}"
                mock_tasks[task_index]["assignee_avatar"] = f"/images/avatars/{assignee_id}.png"
        if priority:
            mock_tasks[task_index]["priority"] = priority
        if due_date is not None:
            mock_tasks[task_index]["due_date"] = due_date
        if tags is not None:
            mock_tasks[task_index]["tags"] = tags
        
        mock_tasks[task_index]["updated_at"] = datetime.now()
        
        return KanbanTask(**mock_tasks[task_index])
    
    raise HTTPException(status_code=500, detail="Failed to update task")

@router.delete("/tasks/{task_id}", response_model=BaseResponse)
async def delete_task(
    task_id: int,
    current_user: dict = Depends(get_current_user)
):
    """Delete a task"""
    task = next((t for t in mock_tasks if t["id"] == task_id), None)
    if not task:
        raise HTTPException(status_code=404, detail="Task not found")
    
    # Remove task
    mock_tasks[:] = [t for t in mock_tasks if t["id"] != task_id]
    
    return BaseResponse(success=True, message="Task deleted successfully")

@router.post("/tasks/{task_id}/move", response_model=KanbanTask)
async def move_task(
    task_id: int,
    column_id: int,
    position: Optional[int] = None,
    current_user: dict = Depends(get_current_user)
):
    """Move a task to a different column"""
    task = next((t for t in mock_tasks if t["id"] == task_id), None)
    if not task:
        raise HTTPException(status_code=404, detail="Task not found")
    
    column = next((c for c in mock_columns if c["id"] == column_id), None)
    if not column:
        raise HTTPException(status_code=404, detail="Column not found")
    
    # Update task
    task_index = next((i for i, t in enumerate(mock_tasks) if t["id"] == task_id), None)
    if task_index is not None:
        mock_tasks[task_index]["column_id"] = column_id
        mock_tasks[task_index]["board_id"] = column["board_id"]
        mock_tasks[task_index]["updated_at"] = datetime.now()
        
        # TODO: Handle position within column if needed
        
        return KanbanTask(**mock_tasks[task_index])
    
    raise HTTPException(status_code=500, detail="Failed to move task")

@router.post("/tasks/{task_id}/comment", response_model=BaseResponse)
async def add_comment(
    task_id: int,
    comment: str,
    current_user: dict = Depends(get_current_user)
):
    """Add a comment to a task"""
    task = next((t for t in mock_tasks if t["id"] == task_id), None)
    if not task:
        raise HTTPException(status_code=404, detail="Task not found")
    
    # Update comment count
    task_index = next((i for i, t in enumerate(mock_tasks) if t["id"] == task_id), None)
    if task_index is not None:
        mock_tasks[task_index]["comments_count"] += 1
        mock_tasks[task_index]["updated_at"] = datetime.now()
        
        # TODO: Store actual comments in a real implementation
        
        return BaseResponse(success=True, message="Comment added successfully")
    
    raise HTTPException(status_code=500, detail="Failed to add comment")