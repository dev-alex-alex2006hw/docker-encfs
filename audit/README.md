```

using gpg from su or sudo su will fail due to /dev/ttyN ownership, ssh instead

speed up gpg key generation:
open another terminal, dd if=/dev/sda of=/dev/zero

pass init email@gmail.com
pass insert user/foo
pass generate user/foo
pass show user/foo

vi /usr/bin/pass GPG_OPTS="$GPG_OPTS --batch --use-agent --passphrase $MYPASS"

/root/.ssh/authorized_keys use wild card with prepaired key root@*

[root@test6 ~]# pass
Password Store
└── user
    ├── chu
    └── vagrant
	
[root@test6 ~]# pass user/vagrant
vagrant

[root@test6 ~]# tree /usr/local/lib -a
/usr/local/lib
└── user_encfs
    |── chu
        |── .encfs6.xml
    |── vagrant
	|── .encfs6.xml
		    
```