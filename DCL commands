mysql> create user 'user1'@'localhost' identified by '1234';
Query OK, 0 rows affected (0.02 sec)

mysql> grant all privileges on order_detailks * to 'user1',@'localhost';
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '* to 'user1',@'localhost'' at line 1
mysql> grant all privileges on order_details * to 'user1'@'localhost';
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '* to 'user1'@'localhost'' at line 1
mysql> grant all privileges on order_details * to 'user1'@'localhost';
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '* to 'user1'@'localhost'' at line 1
mysql> GRANT ALL PRIVILEGES ON product.order_details TO 'user1'@'localhost';
Query OK, 0 rows affected (0.01 sec)

mysql> show grants for 'user1'@'localhost';
+--------------------------------------------------------------------------+
| Grants for user1@localhost                                               |
+--------------------------------------------------------------------------+
| GRANT USAGE ON *.* TO `user1`@`localhost`                                |
| GRANT ALL PRIVILEGES ON `product`.`order_details` TO `user1`@`localhost` |
+--------------------------------------------------------------------------+
2 rows in set (0.00 sec)

mysql> revoke delete,update on order_details* from 'user1'@'localhost';
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '* from 'user1'@'localhost'' at line 1
mysql> REVOKE DELETE, UPDATE ON product.order_details FROM 'user1'@'localhost';
Query OK, 0 rows affected (0.01 sec)

