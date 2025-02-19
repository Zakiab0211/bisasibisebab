FROM python:3.9-slim-buster

# Expose the port that Streamlit will run on
EXPOSE 8501

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libgl1-mesa-glx \                   
    software-properties-common \
    git \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Copy the requirements file first to leverage Docker cache
COPY requirements.txt .

# Install Python dependencies
# RUN pip install --upgrade pip 
# RUN pip install -r requirements.txt
# RUN pip install --upgrade pip && pip install -r requirements.txt
RUN pip3 install -r requirements.txt
RUN python -m pip install -r requirements.txt

# Copy the rest of the application code
COPY . .

# Set the entry point to run the Streamlit app
ENTRYPOINT ["streamlit", "run", "app.py", "--server.port=8501", "--server.address=0.0.0.0"]