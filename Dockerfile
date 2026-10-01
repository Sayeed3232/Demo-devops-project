# Use official lightweight Python image
FROM python:3.11-slim
# Set working directory inside container
WORKDIR /app
# Prevent Python from writing bytecode and buffer stdout/stderr
ENV PYTHONDONTWRITEBYTECODE=1 \
   PYTHONUNBUFFERED=1
# Copy and install python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
# Copy application source code
COPY app.py .
# Expose container port
EXPOSE 5000
# Create a non-root user for security best practices
RUN useradd -m appuser && chown -R appuser:appuser /app
USER appuser
# Run application using Gunicorn production WSGI server
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "--workers", "2", "app:app"]
