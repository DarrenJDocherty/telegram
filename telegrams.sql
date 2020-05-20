CREATE TABLE IF NOT EXISTS `telegrams` (
  `id` int(11) NOT NULL,
  `sender` varchar(30) NOT NULL,
  `message` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `telegrams`
ADD PRIMARY KEY (`id`);

ALTER TABLE `telegrams`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
COMMIT;
