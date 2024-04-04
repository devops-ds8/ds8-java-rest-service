# Start with a base image containing Java runtime
FROM openjdk:17-jdk-alpine

# Install Gradle
RUN apk add --no-cache gradle

# Make port 8081 available to the world outside this container
EXPOSE 8081

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Grant permissions for the gradlew script to execute 
RUN chmod +x ./gradlew

# Build the project and run the application
ENTRYPOINT ["./gradlew", "bootRun"]