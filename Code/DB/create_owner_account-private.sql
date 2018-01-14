CREATE TABLE `manager_account` (
  `manager_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `salt` varchar(15) NOT NULL,
  PRIMARY KEY (`manager_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1002 DEFAULT CHARSET=latin1;

/*
encrypted
*/
insert into manager_account(manager_id, username,password,salt)
values(1000, aes_encrypt(concat('edirect_root', '7Lp-%xkz'), 'xZ0&8!lkqw'),aes_encrypt(concat('Tg#903.nc8Lx@+', '7Lp-%xkz'), 'xZ0&8!lkqw'), '7Lp-%xkz');

/*
decrypted
*/
SELECT 
    manager_id,
    REPLACE(CAST(AES_DECRYPT(username, 'xZ0&8!lkqw') AS CHAR (100)),salt,''),
    REPLACE(CAST(AES_DECRYPT(password, 'xZ0&8!lkqw') AS CHAR (100)),salt,''),
    salt
FROM
    manager_account;
    
insert into manager_account (manager_id, username, password, salt) values (1001, 'micha', 'colombia1', 'n/a');