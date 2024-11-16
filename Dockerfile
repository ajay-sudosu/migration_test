# Use an official Python image as the base
FROM python:3.10-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the app and Alembic files into the container
COPY . .

# Expose the port the app runs on
EXPOSE 8000

# Set the entrypoint command to run Alembic migrations and then start the app
CMD bash -c "alembic upgrade head && uvicorn main:app --host 0.0.0.0 --port 8000 --reload"
