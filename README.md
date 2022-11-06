# Tachidesk Server
> Quick Deploy Guide for Replit, Railway, Render, Goorm, Okteto etc.

Telling which one is better would lead to service abuse, so find out the best one yourself :)

## Replit
1. Fork the repo and connect Replit with your GitHub account.
2. Repl servers block most 18+ sites so you need a working SOCKS5 proxy to unblock those extensions. You can try searching online for free SOCKS5 proxies but most of them will probably be dead so you can either create a proxy server yourself or buy them. Now, if you finally get your hands on one, you can just edit the `server.conf` file and add the proxy if your repl is private or just put them as env variables if otherwise.
3. Now all you need to do is run the repl and you're good to go.

Note:
- Replit servers are hosted on USA so use an USA based proxy for best performance.
- Replit doesn't offer much storage even on paid plan so you should always turn off cache.

## Railway
1. Fork the repo and connect Railway with your GitHub account.
2. Set the `PORT` environment variable with the value `4567`.
3. Deploy using the fork repo.

Notes:
- You don't need a proxy for Railway.
- Restart the deployment everytime you want to update the server to the latest version.
- Railway has an ephemeral filesystem, so everytime you trigger a new deployment, all of your previous data (library, installed extensions and downloads) will be wiped.

## Render
1. Fork the repo and connect Render with your GitHub account.
2. Deploy, that's it.

## Goorm
> W.I.P

## Okteto
> W.I.P
