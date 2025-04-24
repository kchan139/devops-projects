# basic-dockerfile
A basic Dockerfile to create a Docker image.

https://roadmap.sh/projects/basic-dockerfile

To build and run this:

1.  Build the Docker image:
    ```bash
    docker build -t hello .
    ```
2.  Run the container:
    ```bash
    docker run hello
    ```
    Output: `Hello, Captain!`

3.  Run the container with a custom name:
    ```bash
    docker run hello <name>
    ```
    Output: `Hello, <name>`