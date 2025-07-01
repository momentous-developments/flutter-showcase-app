from fastapi import APIRouter, Query, HTTPException, Depends
from typing import Optional, List
from datetime import datetime, timedelta
import random

from models import (
    Course, CourseStatus, PaginatedResponse, BaseResponse,
    PaginationParams, SortParams, SearchParams
)
from utils import (
    generate_mock_courses, paginate_data, filter_data,
    search_data, sort_data, load_mock_data
)
from .auth import get_current_user

router = APIRouter()

# Load or generate mock data
mock_courses = generate_mock_courses()
mock_enrollments = []
mock_progress = {}

@router.get("/courses", response_model=PaginatedResponse)
async def get_courses(
    limit: int = Query(10, ge=1, le=100),
    offset: int = Query(0, ge=0),
    category: Optional[str] = None,
    status: Optional[CourseStatus] = None,
    min_rating: Optional[float] = Query(None, ge=0, le=5),
    max_price: Optional[float] = None,
    search: Optional[str] = None,
    sort_by: Optional[str] = Query(None, regex="^(title|price|rating|enrolled_students|created_at)$"),
    order: Optional[str] = Query("asc", regex="^(asc|desc)$")
):
    """Get all courses with filtering, sorting, and pagination"""
    courses = mock_courses.copy()
    
    # Apply filters
    if category:
        courses = [c for c in courses if c["category"].lower() == category.lower()]
    if status:
        courses = [c for c in courses if c["status"] == status]
    if min_rating:
        courses = [c for c in courses if c["rating"] >= min_rating]
    if max_price is not None:
        courses = [c for c in courses if c["price"] <= max_price]
    
    # Apply search
    if search:
        courses = search_data(courses, search, ["title", "description", "instructor", "category"])
    
    # Apply sorting
    if sort_by:
        courses = sort_data(courses, sort_by, order)
    
    # Apply pagination
    result = paginate_data(courses, limit, offset)
    
    return PaginatedResponse(
        success=True,
        **result
    )

@router.get("/courses/{course_id}", response_model=Course)
async def get_course(course_id: int):
    """Get a specific course by ID"""
    course = next((c for c in mock_courses if c["id"] == course_id), None)
    if not course:
        raise HTTPException(status_code=404, detail="Course not found")
    return course

@router.get("/courses/{course_id}/curriculum")
async def get_course_curriculum(course_id: int):
    """Get course curriculum with modules and lessons"""
    course = next((c for c in mock_courses if c["id"] == course_id), None)
    if not course:
        raise HTTPException(status_code=404, detail="Course not found")
    
    # Generate mock curriculum
    modules = []
    total_lessons = course["total_lessons"]
    lessons_per_module = total_lessons // 5  # Assume 5 modules per course
    
    for i in range(1, 6):
        module_lessons = []
        for j in range(1, lessons_per_module + 1):
            lesson_num = (i - 1) * lessons_per_module + j
            module_lessons.append({
                "id": lesson_num,
                "title": f"Lesson {lesson_num}: Topic {j}",
                "duration": f"{random.randint(5, 30)}m",
                "type": random.choice(["video", "article", "quiz", "assignment"]),
                "is_completed": lesson_num <= course["completed_lessons"],
                "is_locked": lesson_num > course["completed_lessons"] + 1
            })
        
        modules.append({
            "id": i,
            "title": f"Module {i}: {random.choice(['Fundamentals', 'Advanced Topics', 'Best Practices', 'Real-world Projects', 'Final Assessment'])}",
            "description": f"Module {i} description covering important concepts",
            "lessons": module_lessons,
            "total_duration": f"{random.randint(60, 180)}m"
        })
    
    return {
        "course_id": course_id,
        "modules": modules,
        "total_modules": len(modules),
        "total_lessons": total_lessons,
        "completed_lessons": course["completed_lessons"]
    }

@router.post("/courses/{course_id}/enroll", response_model=BaseResponse)
async def enroll_in_course(
    course_id: int,
    current_user: dict = Depends(get_current_user)
):
    """Enroll current user in a course"""
    course = next((c for c in mock_courses if c["id"] == course_id), None)
    if not course:
        raise HTTPException(status_code=404, detail="Course not found")
    
    # Check if already enrolled
    enrollment = next(
        (e for e in mock_enrollments if e["user_id"] == current_user["id"] and e["course_id"] == course_id),
        None
    )
    
    if enrollment:
        raise HTTPException(status_code=400, detail="Already enrolled in this course")
    
    # Create enrollment
    new_enrollment = {
        "id": len(mock_enrollments) + 1,
        "user_id": current_user["id"],
        "course_id": course_id,
        "enrolled_at": datetime.now(),
        "progress": 0,
        "completed_lessons": 0,
        "last_accessed": datetime.now()
    }
    
    mock_enrollments.append(new_enrollment)
    
    # Update course enrollment count
    course_index = next((i for i, c in enumerate(mock_courses) if c["id"] == course_id), None)
    if course_index is not None:
        mock_courses[course_index]["enrolled_students"] += 1
    
    return BaseResponse(success=True, message="Successfully enrolled in course")

@router.get("/my-courses", response_model=PaginatedResponse)
async def get_my_courses(
    limit: int = Query(10, ge=1, le=100),
    offset: int = Query(0, ge=0),
    status: Optional[str] = Query(None, regex="^(active|completed|all)$"),
    current_user: dict = Depends(get_current_user)
):
    """Get courses enrolled by current user"""
    # Get user's enrollments
    user_enrollments = [e for e in mock_enrollments if e["user_id"] == current_user["id"]]
    
    # Get enrolled courses
    enrolled_courses = []
    for enrollment in user_enrollments:
        course = next((c for c in mock_courses if c["id"] == enrollment["course_id"]), None)
        if course:
            # Add enrollment info to course
            enriched_course = course.copy()
            enriched_course.update({
                "enrollment_id": enrollment["id"],
                "enrolled_at": enrollment["enrolled_at"].isoformat(),
                "progress": enrollment["progress"],
                "last_accessed": enrollment["last_accessed"].isoformat(),
                "is_completed": enrollment["progress"] >= 100
            })
            
            # Apply status filter
            if status == "active" and enriched_course["is_completed"]:
                continue
            elif status == "completed" and not enriched_course["is_completed"]:
                continue
            
            enrolled_courses.append(enriched_course)
    
    # Apply pagination
    result = paginate_data(enrolled_courses, limit, offset)
    
    return PaginatedResponse(
        success=True,
        **result
    )

@router.put("/courses/{course_id}/progress", response_model=BaseResponse)
async def update_course_progress(
    course_id: int,
    lesson_id: int,
    completed: bool = True,
    current_user: dict = Depends(get_current_user)
):
    """Update course progress for current user"""
    # Find enrollment
    enrollment = next(
        (e for e in mock_enrollments if e["user_id"] == current_user["id"] and e["course_id"] == course_id),
        None
    )
    
    if not enrollment:
        raise HTTPException(status_code=404, detail="Enrollment not found")
    
    # Get course
    course = next((c for c in mock_courses if c["id"] == course_id), None)
    if not course:
        raise HTTPException(status_code=404, detail="Course not found")
    
    # Update progress
    user_progress_key = f"{current_user['id']}_{course_id}"
    if user_progress_key not in mock_progress:
        mock_progress[user_progress_key] = {"completed_lessons": set()}
    
    if completed:
        mock_progress[user_progress_key]["completed_lessons"].add(lesson_id)
    else:
        mock_progress[user_progress_key]["completed_lessons"].discard(lesson_id)
    
    # Calculate progress percentage
    completed_count = len(mock_progress[user_progress_key]["completed_lessons"])
    progress_percentage = (completed_count / course["total_lessons"]) * 100
    
    # Update enrollment
    enrollment_index = next(
        (i for i, e in enumerate(mock_enrollments) if e["id"] == enrollment["id"]),
        None
    )
    if enrollment_index is not None:
        mock_enrollments[enrollment_index]["progress"] = progress_percentage
        mock_enrollments[enrollment_index]["completed_lessons"] = completed_count
        mock_enrollments[enrollment_index]["last_accessed"] = datetime.now()
    
    return BaseResponse(
        success=True,
        message=f"Progress updated: {progress_percentage:.1f}% complete"
    )

@router.get("/instructors")
async def get_instructors(
    limit: int = Query(10, ge=1, le=100),
    offset: int = Query(0, ge=0)
):
    """Get list of course instructors"""
    # Get unique instructors from courses
    instructors_map = {}
    
    for course in mock_courses:
        instructor_name = course["instructor"]
        if instructor_name not in instructors_map:
            instructors_map[instructor_name] = {
                "id": len(instructors_map) + 1,
                "name": instructor_name,
                "avatar": course["instructor_avatar"],
                "bio": f"Experienced instructor specializing in {course['category']}",
                "courses_count": 0,
                "students_count": 0,
                "rating": 0,
                "total_reviews": 0
            }
        
        # Update stats
        instructors_map[instructor_name]["courses_count"] += 1
        instructors_map[instructor_name]["students_count"] += course["enrolled_students"]
        instructors_map[instructor_name]["rating"] += course["rating"]
        instructors_map[instructor_name]["total_reviews"] += course["reviews_count"]
    
    # Calculate average ratings
    instructors = []
    for instructor in instructors_map.values():
        if instructor["courses_count"] > 0:
            instructor["rating"] = round(instructor["rating"] / instructor["courses_count"], 1)
        instructors.append(instructor)
    
    # Apply pagination
    result = paginate_data(instructors, limit, offset)
    
    return result

@router.get("/categories")
async def get_categories():
    """Get all available course categories"""
    categories = {}
    
    for course in mock_courses:
        category = course["category"]
        if category not in categories:
            categories[category] = {
                "name": category,
                "slug": category.lower().replace(" ", "-"),
                "courses_count": 0,
                "icon": f"tabler-{category.lower().replace(' ', '-')}"
            }
        categories[category]["courses_count"] += 1
    
    return {
        "categories": list(categories.values()),
        "total": len(categories)
    }

@router.post("/courses/{course_id}/review", response_model=BaseResponse)
async def add_course_review(
    course_id: int,
    rating: float = Query(..., ge=1, le=5),
    comment: str = "",
    current_user: dict = Depends(get_current_user)
):
    """Add a review for a course"""
    course = next((c for c in mock_courses if c["id"] == course_id), None)
    if not course:
        raise HTTPException(status_code=404, detail="Course not found")
    
    # Check if enrolled
    enrollment = next(
        (e for e in mock_enrollments if e["user_id"] == current_user["id"] and e["course_id"] == course_id),
        None
    )
    
    if not enrollment:
        raise HTTPException(status_code=403, detail="Must be enrolled to review course")
    
    # Update course rating (simplified calculation)
    course_index = next((i for i, c in enumerate(mock_courses) if c["id"] == course_id), None)
    if course_index is not None:
        current_rating = mock_courses[course_index]["rating"]
        current_count = mock_courses[course_index]["reviews_count"]
        
        # Calculate new rating
        new_count = current_count + 1
        new_rating = ((current_rating * current_count) + rating) / new_count
        
        mock_courses[course_index]["rating"] = round(new_rating, 1)
        mock_courses[course_index]["reviews_count"] = new_count
    
    return BaseResponse(success=True, message="Review added successfully")