# Setup Instructions

Because of permission restrictions (need for `sudo`), I cannot complete the build process automatically.

Please follow these steps manually:

1.  **Navigate to the directory**:
    ```bash
    cd /home/enving/Dev/Repositories/coding_template/autonomous_agent_env
    ```

2.  **Run the Setup Script with Sudo**:
    ```bash
    sudo ./setup_env.sh
    ```
    *Enter your password when prompted.*
    *This will build the image (including `firecrawl-cli`) and drop you into a container shell.*

3.  **Authenticate**:
    - Inside the container, run:
      ```bash
      opencode auth login
      ```
    - Follow the authentication URL.

4.  **Running the Agent**:
    - After authentication, type `exit` to leave the container.
    - You can now use the agent wrapper:
      ```bash
      ./run_agent.sh
      ```
