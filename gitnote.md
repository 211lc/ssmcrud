工作区-> git add -> 暂存区 -> git commit -> 本地库

## Git

### 本地仓库

- #### 初始化本地仓库:创建仓库、创建标识符

```shell
git init // 创建git仓库
git config user.name 用户名
git config user.email 邮箱 // 创建仓库级别的标识符
git config --global user.name 用户名
git config --global user.email 邮箱 // 创建系统级别的标识符
// 一般用  git config --global ，因为省力
```

- #### 	基本命令

  ```shell
  git status // 查看git当前暂存区，本地仓库，分支状态
  git add 文件名 // 将工作区文件提交到暂存区
  git rm --cached 文件名 // 将暂存区文件重新返回到工作区
  git commit -m "提交信息" 文件名 // 将暂存区文件提交到本体仓库
  git log		git log --oneline	git reflog // 查看历史记录的三种常用方式
  // git 版本穿梭的三种主要方式
  git reset --hard 索引值 // 主要的版本穿梭方法，能回退，能前进
  git reset --hard HEAD^ // 一个^代表回退一次，只能回退
  git reset --hard HEAD~n // n代表回退几个版本，如果为1，代表往回退一个版本，只能回退
  git diff 文件名 // 拿工作区和暂存区比较不同
  git diff [HEAD/索引值] 文件名 // 拿工作区和本地仓库比较不同
  ```


- #### 	分支

  ```sh
  git branch -v // 查看分支
  git branch 分支名 // 新建分支
  git checkout 分支名 // 切换分支
  git merge 分支名 // 合并分支，所跟分支名是要加入到当前分支的另一个分支的分支名
  git commit -m "... " // 冲突解决，分支合并解决冲突时，直接git commit -m,不用加文件名
  ```

### 远程仓库

```shell
git remote -v // 查看本地远程库
git remote add 远程库别名 远程库https地址 // 在本地创建远程库别名
git push 远程库别名 要推送的本地分支名 // 推送本地分支到远程库
git clone 远程库地址 // 克隆远程库到本地
git fetch 远程库别名 远程库分支名 // 将远程库分支抓取到本地git分支
git merge 远程库别名/远程库分支名 // 合并
git pull 远程库别名 远程库分支名 // 相当于git fetch + git merge 
ssh-keygen -t rsa -C github邮箱名 // 生成ssh地址，在github中将id_rsa.pub里面的地址设置
```



