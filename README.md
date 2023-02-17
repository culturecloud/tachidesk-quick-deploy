<p align="center"><img src="https://github.com/Suwayomi/Tachidesk/raw/master/server/src/main/resources/icon/faviconlogo.png" alt="drawing" width="200"/></p>

# What is This?
[Tachidesk](https://github.com/Suwayomi/Tachidesk-Server) is a desktop/server port of [Tachiyomi](https://tachiyomi.org), THE LEGENDARY free and open-source manga reader for mobile devices. This repo hosts some ready made scripts that make deploying Tachidesk easier on Dockerfile supported PaaS like Heroku, Railway, Render etc.

## How to deploy?
1. Fork, or use this repo directly if the PaaS supports it, doesn't actually matter.
2. There are two ways you can use this repo. With automated cloud backup support, or without. I recommend the former since most platforms this repo was designed for offer temporary/ephemeral storage and you most probably don't want to lose your data. (Yes, I know that Tachidesk supports backing up library entries but what i wanted was a more automated and hassle free solution, this repo tries to accomplish exactly that)
3. If you decided how you want to deploy, just head to the next section and prepare the necessary variables needed for automated cloud backups.

## Environment Setup
Required for normal setup.
| Variable Name |                                                                                                       Details                                                                                                       | Required |      Default      |        Example        |
|:-------------:|:-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------:|:--------:|:-----------------:|:---------------------:|
|     `PORT`    | The web port of Tachidesk Server. Platforms like Heroku, Render or Railway offer a PORT variable for your application by default. If leaving it to grab the default port causes some issue, try to set it manually. |    Yes   | Platform provided |           80          |
|    `BRANCH`   | The branch of Tachidesk you want to deploy. There are two options, `stable` or `preview`. The latter is unstable as it is built on every new push on the main repo.                                                 |    Yes   |     `stable`      | `stable` or `preview` |
|  `AUTH_USER`  | Username for basic authentication. You need to set this manually.                                                                                                                                                   |    Yes   |        N/A        |         `user`        |
|  `AUTH_PASS`  | Password for basic authentication. You need to set this manually.                                                                                                                                                   |    Yes   |        N/A        |         `pass`        |

Required for automated backups using Rclone.
|         Name         |                                                                                                                                                                                 Details                                                                                                                                                                                 |                    Required                   | Default |                       Example                      |
|:--------------------:|:-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------:|:---------------------------------------------:|:-------:|:--------------------------------------------------:|
|  `BACKUP_FREQUENCY`  |                                                                   This decides how frequent you want to run the backup task. Value should be in seconds. Depending on the size of your library and how frequent you add/delete/download entries, you should not set this value to smaller than `900`.                                                                   |                      Yes                      |  `3600` |                        `900`                       |
|     `RCLONE_CONF`    | Direct URL to a `rclone.conf` file which contains a remote named `backup`. You can generate the config file using a local Rclone installation on your device. Guiding how to setup rclone locally is beyond the scope of this project so you have to manage that yourself. If you're on mobile device, you can use an app called RCX abailable on Play Store or GitHub. |                      Yes                      |   N/A   | `https://gist.github.com/abcd1234/raw/rclone.conf` |
| `RCLONE_CONFIG_PASS` |                                                                                                           If the `rclone.conf` file you've provided in the `RCLONE_CONF` variable is encrypted locally, set the decryption key as the value to this variable.                                                                                                           | Yes (If your configuration file is encrypted) |   N/A   |                         N/A                        |

✍️ Notes:
- If you don't want automated cloud backups then don't set the `RCLONE_CONF` variable at all.

## Platform Specific Deploy Steps
### Replit
1. Fork the repo and connect Replit with your GitHub account.
2. Set necessary environment variables using the secrets tab.
3. Now all you need to do is run the repl and you're good to go.

Note:
- Repl servers block most NSFW sites so you need a working SOCKS5 proxy to unblock those extensions. You can try searching online for free SOCKS5 proxies but most of them will probably be dead so you can either create a proxy server yourself or buy them. Now, if you finally get your hands on one, you can just edit the `server.conf` located inside `tachidesk` folder and add the proxy details.

### Railway
1. Fork the repo and connect Railway with your GitHub account.
2. Create a new project and a service using the forked repo.
3. Set necessary environment variables.
4. Trigger a new deployment if the previous deployment failed (Add a random environment variable)

### Render
1. Make a new Render account.
2. Copy the URL of this repo, create a new web service from it.
3. Set necessary environment variables.
4. Deploy, that's it.

#### 💡 Extra Tips
- Restart/redeploy the service everytime you want to update the server to the latest available version.