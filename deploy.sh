#!/bin/bash

# Flutter Material 3 Demo - Deployment Script
echo "🚀 Deploying Flutter Material 3 Demo with Forms, Tables, and Email modules"

# Build the project
echo "📦 Building Flutter web app..."
flutter build web --no-tree-shake-icons

# Check if build was successful
if [ $? -eq 0 ]; then
    echo "✅ Build completed successfully!"
    
    # Deploy to Firebase (requires authentication)
    echo "🔄 Deploying to Firebase..."
    firebase deploy --only hosting
    
    if [ $? -eq 0 ]; then
        echo "🎉 Deployment completed successfully!"
        echo "🌐 Your app with working Forms, Tables, and Email modules is now live!"
    else
        echo "❌ Deployment failed. Please run 'firebase login' to authenticate."
        echo "📁 Build files are ready in build/web/ directory"
    fi
else
    echo "❌ Build failed. Please check the errors above."
fi