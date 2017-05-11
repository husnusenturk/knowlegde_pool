Setup your user name for github account: `git config --global user.name "username"`  
Setup your e-mail id for github account: `git config --global user.email john@doo.com`  
Getting git to work with a proxy server: `git config --global http.proxy http://proxyuser:proxypwd@proxy.server.com:8080`  
Check the currently set proxy: `git config --global --get http.proxy`  
Reset proxy and work without proxy: `git config --global --unset http.proxy`  

How to clone repository from github to local computer:
```bash
$ git clone https://github.com/husnusenturk/regex.git
Cloning into 'regex'...
fatal: unable to access 'https://github.com/husnusenturk/regex.git/': SSL certificate problem: unable to get local issuer certificate
```
You have a couple of different options for how to work around this problem. The easy way is to just disable SSL certificate validation entirely:
`git config http.sslVerify "false"`  

If you want to store credentials on disk: `git config --global credential.helper store`  
Using this helper will store your passwords **unencrypted** on disk, protected only by filesystem permissions. If you use this helper your 
credentials will be written c:\Users\<username>\.git-credentials by default.  

If you want to store credentials on windows credential store: `git config --global credential.helper wincred`  

If you use `git clone`or `git push` command for the first time, your credentials will be stored and your credentials will not be asked again.  

All this parameters are preserved in c:\Users\<username>\.gitconfig file. You can change this parameters manually on this file.  

Compare local git repository and remote repository: `git status`  
Send changes to remote repository:  `git push`  
