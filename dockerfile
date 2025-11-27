# Use the official busybox image as the base
FROM busybox:latest

# Set the command to run when the container starts
CMD ["echo", "Hello, Docker with BusyBox!"]