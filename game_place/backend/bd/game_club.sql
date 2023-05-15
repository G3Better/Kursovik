-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1
-- Время создания: Май 15 2023 г., 11:44
-- Версия сервера: 10.4.28-MariaDB
-- Версия PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `game_club`
--

DELIMITER $$
--
-- Процедуры
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `ADD_USER` ()   INSERT INTO `users` (`REG_Number`, `Name`, `FIO`, `Users_Type_REG_Number`) VALUES (NULL, 'test_procedure', 'Procedure Test 1', '1')$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DEL_COMP_CAT` ()   DELETE FROM `computers_category` WHERE
`computers_category`.`REG_Number` = 4$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UPD_USER` ()   UPDATE `users` SET `Name` = 'test_procedure_1' WHERE
`users`.`REG_Number` = 14$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Структура таблицы `booking`
--

CREATE TABLE `booking` (
  `REG_Number` int(11) NOT NULL,
  `Incoming_DateTIme` datetime NOT NULL,
  `Rental_Time` int(11) NOT NULL,
  `Users_REG_Number` int(11) NOT NULL,
  `Game_Places_REG_Number` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Дамп данных таблицы `booking`
--

INSERT INTO `booking` (`REG_Number`, `Incoming_DateTIme`, `Rental_Time`, `Users_REG_Number`, `Game_Places_REG_Number`) VALUES
(26, '2023-05-14 22:25:30', 4, 4, 40),
(27, '2023-05-14 22:25:30', 1, 1, 41),
(28, '2023-05-14 22:25:30', 4, 4, 40),
(29, '2023-05-14 22:25:30', 1, 1, 41),
(31, '0000-00-00 00:00:00', 55, 4, 40);

-- --------------------------------------------------------

--
-- Структура таблицы `computers`
--

CREATE TABLE `computers` (
  `REG_Number` int(11) NOT NULL,
  `Name` varchar(45) NOT NULL,
  `Details` varchar(115) DEFAULT NULL,
  `Computers_Category_REG_Number` int(11) NOT NULL,
  `Store_REG_Number` int(11) DEFAULT NULL,
  `Status_REG_Number` int(11) NOT NULL,
  `Game_Places_REG_Number` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Дамп данных таблицы `computers`
--

INSERT INTO `computers` (`REG_Number`, `Name`, `Details`, `Computers_Category_REG_Number`, `Store_REG_Number`, `Status_REG_Number`, `Game_Places_REG_Number`) VALUES
(63, 'Стандартный', 'Стандартный компьютер', 2, NULL, 8, NULL),
(64, 'Стандартный', 'Стандартный компьютер', 2, NULL, 8, NULL),
(65, 'Стандартный 2', 'Стандартный компьютер', 2, NULL, 8, NULL),
(66, 'Стандартный 3', 'Стандартный компьютер', 2, NULL, 8, NULL);

--
-- Триггеры `computers`
--
DELIMITER $$
CREATE TRIGGER `Add_new_computer` AFTER INSERT ON `computers` FOR EACH ROW UPDATE `game_places` SET
`Computers_REG_Number` = NEW.REG_Number WHERE
`game_places`.`REG_Number` = NEW.Game_Places_REG_Number
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `Update_computer` AFTER UPDATE ON `computers` FOR EACH ROW UPDATE `game_places` SET `Computers_REG_Number` = NEW.REG_Number WHERE `game_places`.`REG_Number` = NEW.Game_Places_REG_Number
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `del_computer` BEFORE DELETE ON `computers` FOR EACH ROW UPDATE `game_places` SET
`Computers_REG_Number` = NULL WHERE
`game_places`.`Computers_REG_Number` = OLD.REG_Number
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Структура таблицы `computers_category`
--

CREATE TABLE `computers_category` (
  `REG_Number` int(11) NOT NULL,
  `Name` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Дамп данных таблицы `computers_category`
--

INSERT INTO `computers_category` (`REG_Number`, `Name`) VALUES
(1, 'Эконом компьютер'),
(2, 'Стандарт компьютер'),
(3, 'Вип компьютер');

-- --------------------------------------------------------

--
-- Структура таблицы `game_places`
--

CREATE TABLE `game_places` (
  `REG_Number` int(11) NOT NULL,
  `Name` varchar(45) NOT NULL,
  `Cost` decimal(10,2) DEFAULT NULL,
  `Computers_REG_Number` int(11) DEFAULT NULL,
  `Status_REG_Number` int(11) NOT NULL,
  `Game_Places_Category_REG_Number` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Дамп данных таблицы `game_places`
--

INSERT INTO `game_places` (`REG_Number`, `Name`, `Cost`, `Computers_REG_Number`, `Status_REG_Number`, `Game_Places_Category_REG_Number`) VALUES
(40, 'test', 142.00, 65, 5, 3),
(41, 'test', 142.00, 65, 5, 3),
(43, 'test', 142.00, 65, 5, 3),
(46, 'test', 142.00, 65, 5, 3);

-- --------------------------------------------------------

--
-- Структура таблицы `game_places_category`
--

CREATE TABLE `game_places_category` (
  `REG_Number` int(11) NOT NULL,
  `Name` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Дамп данных таблицы `game_places_category`
--

INSERT INTO `game_places_category` (`REG_Number`, `Name`) VALUES
(1, 'Стандартная зона'),
(2, 'Эконом зона'),
(3, 'VIP зона'),
(4, 'Командная комната 1');

-- --------------------------------------------------------

--
-- Структура таблицы `order`
--

CREATE TABLE `order` (
  `REG_Number` int(11) NOT NULL,
  `Start_DateTime` datetime NOT NULL,
  `Rental_Time` time NOT NULL,
  `Sum` decimal(10,0) NOT NULL,
  `Users_REG_Number` int(11) NOT NULL,
  `Users_REG_Number_Admin` int(11) NOT NULL,
  `Game_Places_REG_Number` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Дамп данных таблицы `order`
--

INSERT INTO `order` (`REG_Number`, `Start_DateTime`, `Rental_Time`, `Sum`, `Users_REG_Number`, `Users_REG_Number_Admin`, `Game_Places_REG_Number`) VALUES
(42, '2023-05-11 21:36:38', '00:00:04', 400, 3, 1, 41),
(43, '2023-05-11 21:36:38', '00:00:04', 400, 3, 1, 41),
(44, '2023-05-11 21:36:38', '00:00:04', 400, 3, 1, 41),
(45, '2023-05-11 21:36:38', '00:00:04', 400, 3, 1, 41),
(46, '2023-05-11 21:36:38', '00:00:04', 400, 3, 1, 41),
(47, '2023-05-11 21:36:38', '00:00:04', 400, 3, 1, 41);

-- --------------------------------------------------------

--
-- Структура таблицы `status`
--

CREATE TABLE `status` (
  `REG_Number` int(11) NOT NULL,
  `Name` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Дамп данных таблицы `status`
--

INSERT INTO `status` (`REG_Number`, `Name`) VALUES
(1, 'Работает'),
(2, 'В ремонте'),
(3, 'На складе'),
(4, 'Сломан'),
(5, 'Свободен'),
(6, 'Занят'),
(7, 'Забронирован'),
(8, 'На игровом месте');

-- --------------------------------------------------------

--
-- Структура таблицы `store`
--

CREATE TABLE `store` (
  `REG_Number` int(11) NOT NULL,
  `Name` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Дамп данных таблицы `store`
--

INSERT INTO `store` (`REG_Number`, `Name`) VALUES
(1, 'Временный склад'),
(2, 'Основной склад');

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `REG_Number` int(11) NOT NULL,
  `Name` varchar(45) DEFAULT NULL,
  `FIO` varchar(115) NOT NULL,
  `password` varchar(18) NOT NULL,
  `Users_Type_REG_Number` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`REG_Number`, `Name`, `FIO`, `password`, `Users_Type_REG_Number`) VALUES
(1, 'root_admin', 'Shestipalov Danila Sergeevich', '', 2),
(2, 'first_client', 'Ivanov Dmitryi Yurivich', '', 1),
(3, 'testerovhik', 'Name Surname FatherName', '', 1),
(4, 'root_admin_backup', 'SDanila Sergeevich', '', 2),
(5, 'second_client', 'IDmitryiYurivich', '', 1),
(6, 'testerovhik2', 'Name Surname FatherName11', '', 1),
(7, 'test_admin', 'Admin Admin Admin', '', 2),
(8, 'third_client', 'Third Client', '', 1),
(9, 'testerovhik3', 'Name3 Surname3 FatherName3', '', 1),
(10, 'client', 'Name4 Surname4 FatherName4', 'client', 1),
(11, 'test', 'client tester', 'test', 2);

-- --------------------------------------------------------

--
-- Структура таблицы `users_type`
--

CREATE TABLE `users_type` (
  `REG_Number` int(11) NOT NULL,
  `Name` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Дамп данных таблицы `users_type`
--

INSERT INTO `users_type` (`REG_Number`, `Name`) VALUES
(1, 'Клиент'),
(2, 'Администратор');

-- --------------------------------------------------------

--
-- Дублирующая структура для представления `пользователи`
-- (См. Ниже фактическое представление)
--
CREATE TABLE `пользователи` (
`REG_Number` int(11)
,`user` varchar(45)
,`FIO` varchar(115)
,`user_type` varchar(45)
);

-- --------------------------------------------------------

--
-- Дублирующая структура для представления `бронирования`
-- (См. Ниже фактическое представление)
--
CREATE TABLE `бронирования` (
`REG_Number` int(11)
,`Incoming_DateTIme` datetime
,`Rental_Time` int(11)
,`FIO` varchar(115)
,`game_place` varchar(45)
);

-- --------------------------------------------------------

--
-- Структура для представления `пользователи`
--
DROP TABLE IF EXISTS `пользователи`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `пользователи`  AS SELECT `users`.`REG_Number` AS `REG_Number`, `users`.`Name` AS `user`, `users`.`FIO` AS `FIO`, `users_type`.`Name` AS `user_type` FROM (`users` join `users_type`) WHERE `users`.`Users_Type_REG_Number` = `users_type`.`REG_Number` ;

-- --------------------------------------------------------

--
-- Структура для представления `бронирования`
--
DROP TABLE IF EXISTS `бронирования`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `бронирования`  AS SELECT `booking`.`REG_Number` AS `REG_Number`, `booking`.`Incoming_DateTIme` AS `Incoming_DateTIme`, `booking`.`Rental_Time` AS `Rental_Time`, `users`.`FIO` AS `FIO`, `game_places`.`Name` AS `game_place` FROM (`booking` join (`game_places` join `users`)) WHERE `booking`.`Users_REG_Number` = `users`.`REG_Number` AND `booking`.`Game_Places_REG_Number` = `game_places`.`REG_Number` ;

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `booking`
--
ALTER TABLE `booking`
  ADD PRIMARY KEY (`REG_Number`),
  ADD KEY `Users_REG_Number` (`Users_REG_Number`),
  ADD KEY `Game_Places_REG_Number` (`Game_Places_REG_Number`);

--
-- Индексы таблицы `computers`
--
ALTER TABLE `computers`
  ADD PRIMARY KEY (`REG_Number`),
  ADD KEY `Computers_Category_REG_Number` (`Computers_Category_REG_Number`,`Store_REG_Number`,`Status_REG_Number`,`Game_Places_REG_Number`),
  ADD KEY `Game_Places_REG_Number` (`Game_Places_REG_Number`),
  ADD KEY `Status_REG_Number` (`Status_REG_Number`),
  ADD KEY `Store_REG_Number` (`Store_REG_Number`);

--
-- Индексы таблицы `computers_category`
--
ALTER TABLE `computers_category`
  ADD PRIMARY KEY (`REG_Number`);

--
-- Индексы таблицы `game_places`
--
ALTER TABLE `game_places`
  ADD PRIMARY KEY (`REG_Number`),
  ADD KEY `Computers_REG_Number` (`Computers_REG_Number`,`Status_REG_Number`,`Game_Places_Category_REG_Number`),
  ADD KEY `Game_Places_Category_REG_Number` (`Game_Places_Category_REG_Number`),
  ADD KEY `Status_REG_Number` (`Status_REG_Number`);

--
-- Индексы таблицы `game_places_category`
--
ALTER TABLE `game_places_category`
  ADD PRIMARY KEY (`REG_Number`);

--
-- Индексы таблицы `order`
--
ALTER TABLE `order`
  ADD PRIMARY KEY (`REG_Number`),
  ADD KEY `Users_REG_Number` (`Users_REG_Number`,`Users_REG_Number_Admin`,`Game_Places_REG_Number`),
  ADD KEY `Game_Places_REG_Number` (`Game_Places_REG_Number`),
  ADD KEY `Users_REG_Number_Admin` (`Users_REG_Number_Admin`);

--
-- Индексы таблицы `status`
--
ALTER TABLE `status`
  ADD PRIMARY KEY (`REG_Number`);

--
-- Индексы таблицы `store`
--
ALTER TABLE `store`
  ADD PRIMARY KEY (`REG_Number`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`REG_Number`),
  ADD KEY `Users_Type_REG_Number` (`Users_Type_REG_Number`);

--
-- Индексы таблицы `users_type`
--
ALTER TABLE `users_type`
  ADD PRIMARY KEY (`REG_Number`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `booking`
--
ALTER TABLE `booking`
  MODIFY `REG_Number` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT для таблицы `computers`
--
ALTER TABLE `computers`
  MODIFY `REG_Number` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=67;

--
-- AUTO_INCREMENT для таблицы `computers_category`
--
ALTER TABLE `computers_category`
  MODIFY `REG_Number` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `game_places`
--
ALTER TABLE `game_places`
  MODIFY `REG_Number` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT для таблицы `game_places_category`
--
ALTER TABLE `game_places_category`
  MODIFY `REG_Number` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT для таблицы `order`
--
ALTER TABLE `order`
  MODIFY `REG_Number` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

--
-- AUTO_INCREMENT для таблицы `status`
--
ALTER TABLE `status`
  MODIFY `REG_Number` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT для таблицы `store`
--
ALTER TABLE `store`
  MODIFY `REG_Number` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `REG_Number` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT для таблицы `users_type`
--
ALTER TABLE `users_type`
  MODIFY `REG_Number` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `booking`
--
ALTER TABLE `booking`
  ADD CONSTRAINT `booking_ibfk_1` FOREIGN KEY (`Users_REG_Number`) REFERENCES `users` (`REG_Number`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `booking_ibfk_2` FOREIGN KEY (`Game_Places_REG_Number`) REFERENCES `game_places` (`REG_Number`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `computers`
--
ALTER TABLE `computers`
  ADD CONSTRAINT `computers_ibfk_1` FOREIGN KEY (`Computers_Category_REG_Number`) REFERENCES `computers_category` (`REG_Number`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `computers_ibfk_2` FOREIGN KEY (`Game_Places_REG_Number`) REFERENCES `game_places` (`REG_Number`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `computers_ibfk_3` FOREIGN KEY (`Status_REG_Number`) REFERENCES `status` (`REG_Number`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `computers_ibfk_4` FOREIGN KEY (`Store_REG_Number`) REFERENCES `store` (`REG_Number`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Ограничения внешнего ключа таблицы `game_places`
--
ALTER TABLE `game_places`
  ADD CONSTRAINT `game_places_ibfk_1` FOREIGN KEY (`Computers_REG_Number`) REFERENCES `computers` (`REG_Number`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `game_places_ibfk_2` FOREIGN KEY (`Game_Places_Category_REG_Number`) REFERENCES `game_places_category` (`REG_Number`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `game_places_ibfk_3` FOREIGN KEY (`Status_REG_Number`) REFERENCES `status` (`REG_Number`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Ограничения внешнего ключа таблицы `order`
--
ALTER TABLE `order`
  ADD CONSTRAINT `order_ibfk_1` FOREIGN KEY (`Game_Places_REG_Number`) REFERENCES `game_places` (`REG_Number`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `order_ibfk_2` FOREIGN KEY (`Users_REG_Number`) REFERENCES `users` (`REG_Number`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `order_ibfk_3` FOREIGN KEY (`Users_REG_Number_Admin`) REFERENCES `users` (`REG_Number`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Ограничения внешнего ключа таблицы `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`Users_Type_REG_Number`) REFERENCES `users_type` (`REG_Number`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
