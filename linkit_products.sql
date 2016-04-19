create database linkit;
use linkit;

create table products (
	id int(11) not null auto_increment,
    name varchar(50) not null,
    spec varchar(255),
    stat varchar(50),
	cost int(11),
    sell int(11),
    amnt int(11),
    primary key (id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;