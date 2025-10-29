# Use a small official Python base image
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Copy only what we need
COPY app.py /app/

# Install small list of required packages
RUN pip install --no-cache-dir Flask

# Expose port 5000
EXPOSE 5000

# Run the app
CMD ["python", "app.py"]
