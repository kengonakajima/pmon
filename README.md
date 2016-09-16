pmon
====
Linux process monitoring (exec, fork, exit, set*uid, set*gid)

Linuxでプロセスが fork/exec/exit/set*uid/set*gid した事象をすべてとらえる。


# ビルド

```
$ cd src
$ make
```

pmon,pmon2,pmon3,pmon4,pmon5　がある。
通常用途ではrootになって、 ./pmon4を起動するだけで全プロセスのイベントをとらえることができる。

- pmon5

pmon5は特別に、親プロセスのIDを指定して、そのプロセスから子がforkしたら、
最初の1個のプロセスIDを取得して、標準出力にプロセスIDを出力して終了する。

よって、以下のようにして、あるプロセスから子が派生したことを瞬時に捉えて、
gdbをアタッチすることができる。

```
gdb /var/lib/server/game_server `./pmon5` -x bt
```

上記でbtというのは、典型的には

```
bt
quit
```

という2行が書かれているファイルで、src/に参考用においてあります。

- src/gdbloop.rb

```
ruby gdbloop.rb 親プロセスID サーバのバイナリ GDBのバッチファイル名
```

以上のようにして、指定した親プロセスの最初の子プロセスに対して、10回連続でgdbのバッチを発行し、
logfileに保存する。

```
ruby gdbloop.rb 32321 /bin/sh bt
```








References:
  - [Original Article](http://bewareofgeek.livejournal.com/2945.html)
  - [The proc connector and socket filters](http://netsplit.com/2011/02/09/the-proc-connector-and-socket-filters/)
  - [StackOverflow: Detect Launching of programs](http://stackoverflow.com/questions/6075013/linux-detect-launching-of-programs)
  - [exec notify](http://users.suse.com/~krahmer/exec-notify.c)
  - [Kernel connector](https://www.kernel.org/doc/Documentation/connector/)
