CREATE DATABASE IF NOT EXISTS GNS;

USE GNS;

CREATE TABLE IF NOT EXISTS users (
    user_id INT(11) NOT NULL AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL,  
    email VARCHAR(100) NOT NULL,  -- Increased from 50 to 100
    password VARCHAR(255) NOT NULL,  -- Increased from 20 to 255 for hashed passwords
    PRIMARY KEY (user_id),
    UNIQUE KEY email (email)
);

CREATE TABLE IF NOT EXISTS emails(
    user_id INT(11),
    email VARCHAR(100),  -- Increased from 30 to 100
    salutation VARCHAR(10),  -- Increased from 5 to 10
    purpose VARCHAR(50),  -- Increased from 20 to 50
    subject VARCHAR(100),  -- Increased from 30 to 100
    message TEXT,  -- Changed from VARCHAR(255) to TEXT for longer messages
    CONSTRAINT PK_WAD_EMAILS PRIMARY KEY (user_id, email),
    CONSTRAINT FK_WAD_EMAILS FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE IF NOT EXISTS games (
    game_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    img_src VARCHAR(500),  -- Increased from 255 to 500 for longer URLs
    `desc` TEXT,
    rating VARCHAR(50),
    rating_num INT,
    release_date DATE,
    developer VARCHAR(255),
    publisher VARCHAR(255),
    price DECIMAL(10, 2)
);

CREATE TABLE IF NOT EXISTS purchases (
    purchase_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    purchase_date DATETIME,
    total_amount DECIMAL(10, 2),
    payment_method VARCHAR(50),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE IF NOT EXISTS purchase_items (
    purchase_item_id INT AUTO_INCREMENT PRIMARY KEY,
    purchase_id INT,
    game_id INT,
    FOREIGN KEY (purchase_id) REFERENCES purchases(purchase_id),  -- Fixed case sensitivity
    FOREIGN KEY (game_id) REFERENCES games(game_id)  -- Fixed case sensitivity
);

-- Insert games data
INSERT INTO `games` (`game_id`, `title`, `img_src`, `desc`, `rating`, `rating_num`, `release_date`, `developer`, `publisher`, `price`) VALUES 
('105600', 'Terraria', 'https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/105600/header.jpg?t=1666290860', 'Dig, fight, explore, build! Nothing is impossible in this action-packed adventure game. Four Pack also available!', 'Overwhelmingly Positive', '1057516', '2011-05-17', 'Re-Logic', 'Re-Logic', '26.75');

INSERT INTO `games` (`game_id`, `title`, `img_src`, `desc`, `rating`, `rating_num`, `release_date`, `developer`, `publisher`, `price`) VALUES 
('814380', 'Sekiro™: Shadows Die Twice - GOTY Edition', 'https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/814380/header.jpg?t=1721684463', 'Game of the Year - The Game Awards 2019 Best Action Game of 2019 - IGN Carve your own clever path to vengeance in the award-winning adventure from developer FromSoftware, creators of Bloodborne and the Dark Souls series. Take Revenge. Restore Your Honor. Kill Ingeniously.', 'Overwhelmingly Positive', '216477', '2019-03-22', 'FromSoftware, Inc.', 'Activision (Excluding Japan and Asia), FromSoftware, Inc. (Japan), 方块游戏 (Asia)', '285.00');

INSERT INTO `games` (`game_id`, `title`, `img_src`, `desc`, `rating`, `rating_num`, `release_date`, `developer`, `publisher`, `price`) VALUES 
('648800', 'Raft', 'https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/648800/header.jpg?t=1725373838', 'Raft™ throws you and your friends into an epic oceanic adventure! Alone or together, players battle to survive a perilous voyage across a vast sea! Gather debris, scavenge reefs, and build your own floating home, but be wary of the man-eating sharks!', 'Very Positive', '274865', '2022-06-21', 'Redbeet Interactive', 'Axolot Games', '38.00');

INSERT INTO `games` (`game_id`, `title`, `img_src`, `desc`, `rating`, `rating_num`, `release_date`, `developer`, `publisher`, `price`) VALUES 
('1245620', 'ELDEN RING', 'https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/1245620/header.jpg?t=1721682743', 'THE NEW FANTASY ACTION RPG. Rise, Tarnished, and be guided by grace to brandish the power of the Elden Ring and become an Elden Lord in the Lands Between.', 'Very Positive', '700781', '2022-02-25', 'FromSoftware, Inc.', 'FromSoftware, Inc., Bandai Namco Entertainment', '199.00');

INSERT INTO `games` (`game_id`, `title`, `img_src`, `desc`, `rating`, `rating_num`, `release_date`, `developer`, `publisher`, `price`) VALUES 
('1551360', 'Forza Horizon 5', 'https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/1551360/header.jpg?t=1723160896', 'Explore the vibrant open world landscapes of Mexico with limitless, fun driving action in the world’s greatest cars. Blast off into Forza Horizon 5: Hot Wheels or Conquer the Sierra Nueva in the ultimate Horizon Rally Adventure experience. Requires Forza Horizon 5 game, expansion sold separately.', 'Very Positive', '175662', '2021-11-09', 'Playground Games', 'Xbox Game Studios', '199.00');

INSERT INTO `games` (`game_id`, `title`, `img_src`, `desc`, `rating`, `rating_num`, `release_date`, `developer`, `publisher`, `price`) VALUES 
('736260', 'Baba Is You', 'https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/736260/header.jpg?t=1698353847', 'Baba Is You is a puzzle game where the rules you have to follow are present as blocks you can interact with. By manipulating them, you can change how the game works, repurpose things you find in the levels, and cause surprising interactions!', 'Overwhelmingly Positive', '17488', '2019-03-14', 'Hempuli Oy', 'Hempuli Oy', '32.00');

INSERT INTO `games` (`game_id`, `title`, `img_src`, `desc`, `rating`, `rating_num`, `release_date`, `developer`, `publisher`, `price`) VALUES 
('1260320', 'Party Animals', 'https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/1260320/header.jpg?t=1719555296', 'Fight your friends as puppies, kittens and other fuzzy creatures in PARTY ANIMALS! Paw it out with your friends remotely, or huddle together for chaotic fun on the same screen. Interact with the world under our realistic physics engine. Did I mention PUPPIES?', 'Mostly Positive', '37750', '2023-09-20', 'Recreate Games', 'Source Technology', '62.00');

INSERT INTO `games` (`game_id`, `title`, `img_src`, `desc`, `rating`, `rating_num`, `release_date`, `developer`, `publisher`, `price`) VALUES 
('1332010', 'Stray', 'https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/1332010/header.jpg?t=1715873569', 'Lost, alone and separated from family, a stray cat must untangle an ancient mystery to escape a long-forgotten cybercity and find their way home.', 'Overwhelmingly Positive', '129193', '2022-07-19', 'BlueTwelve Studio', 'Annapurna Interactive', '69.00');

INSERT INTO `games` (`game_id`, `title`, `img_src`, `desc`, `rating`, `rating_num`, `release_date`, `developer`, `publisher`, `price`) VALUES 
('1593500', 'God of War', 'https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/1593500/header.jpg?t=1721154083', 'His vengeance against the Gods of Olympus years behind him, Kratos now lives as a man in the realm of Norse Gods and monsters. It is in this harsh, unforgiving world that he must fight to survive… and teach his son to do the same.', 'Overwhelmingly Positive', '97379', '2022-01-14', 'Santa Monica Studio, Jetpack Interactive', 'PlayStation Publishing LLC', '209.00');

INSERT INTO `games` (`game_id`, `title`, `img_src`, `desc`, `rating`, `rating_num`, `release_date`, `developer`, `publisher`, `price`) VALUES 
('2358720', 'Black Myth: Wukong', 'https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/2358720/header.jpg?t=1725007201', 'Black Myth: Wukong is an action RPG rooted in Chinese mythology. You shall set out as the Destined One to venture into the challenges and marvels ahead, to uncover the obscured truth beneath the veil of a glorious legend from the past.', 'Overwhelmingly Positive', '561242', '2024-08-20', 'Game Science', 'Game Science', '219.00');

INSERT INTO `games` (`game_id`, `title`, `img_src`, `desc`, `rating`, `rating_num`, `release_date`, `developer`, `publisher`, `price`) VALUES 
('1091500', 'Cyberpunk 2077', 'https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/1091500/header.jpg?t=1721647847', 'Cyberpunk 2077 is an open-world, action-adventure story set in Night City, a megalopolis obsessed with power, glamour, and body modification. You play as V, a mercenary outlaw going after a one-of-a-kind implant that is the key to immortality.', 'Very Positive', '555496', '2020-12-09', 'CD PROJEKT RED', 'CD PROJEKT RED', '159.00');

INSERT INTO `games` (`game_id`, `title`, `img_src`, `desc`, `rating`, `rating_num`, `release_date`, `developer`, `publisher`, `price`) VALUES 
('477160', 'Human Fall Flat', 'https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/477160/header.jpg?t=1725024378', 'Human Fall Flat is a hilarious, light-hearted platformer set in floating dreamscapes that can be played solo or with up to 8 players online. Free new levels keep its vibrant community rewarded.', 'Very Positive', '156164', '2016-07-23', 'No Brakes Games', 'Curve Games', '38.00');

INSERT INTO `games` (`game_id`, `title`, `img_src`, `desc`, `rating`, `rating_num`, `release_date`, `developer`, `publisher`, `price`) VALUES 
('1509960', 'PICO PARK', 'https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/1509960/header.jpg?t=1723719485', 'PICO PARK is a cooperative local/online multiplay action puzzle game for 2-8 players.', 'Very Positive', '20817', '2021-05-07', 'TECOPARK', 'TECOPARK', '12.50');

INSERT INTO `games` (`game_id`, `title`, `img_src`, `desc`, `rating`, `rating_num`, `release_date`, `developer`, `publisher`, `price`) VALUES 
('3590', 'Plants vs. Zombies GOTY Edition', 'https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/3590/header.jpg?t=1615390608', "Zombies are invading your home, and the only defense is your arsenal of plants! Armed with an alien nursery-worth of zombie-zapping plants like peashooters and cherry bombs, you\'ll need to think fast and plant faster to stop dozens of types of zombies dead in their tracks.", 'Overwhelmingly Positive', '119838', '2009-05-06', 'PopCap Games, Inc.', 'PopCap Games, Inc., Electronic Arts', '12.00');

INSERT INTO `games` (`game_id`, `title`, `img_src`, `desc`, `rating`, `rating_num`, `release_date`, `developer`, `publisher`, `price`) VALUES 
('1426210', 'It Takes Two', 'https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/1426210/header.jpg?t=1725585631', 'Embark on the craziest journey of your life in It Takes Two. Invite a friend to join for free with Friend’s Pass and work together across a huge variety of gleefully disruptive gameplay challenges. Winner of GAME OF THE YEAR at the Game Awards 2021.', 'Very Positive', '149401', '2021-03-26', 'Hazelight Studios', 'Electronic Arts', '139.00');

INSERT INTO `games` (`game_id`, `title`, `img_src`, `desc`, `rating`, `rating_num`, `release_date`, `developer`, `publisher`, `price`) VALUES 
('2881650', 'Content Warning', 'https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/2881650/header.jpg?t=1723198595', 'Film your friends doing scary things to become SpöökTube famous! (strongly advised to not go alone)', 'Very Positive', '33770', '2024-04-01', 'thePetHen, Skog, Zorro, Wilnyl, Philip', 'Landfall', '21.75');

INSERT INTO `games` (`game_id`, `title`, `img_src`, `desc`, `rating`, `rating_num`, `release_date`, `developer`, `publisher`, `price`) VALUES 
('601150', 'Devil May Cry 5', 'https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/601150/header.jpg?t=1701395090', 'The ultimate Devil Hunter is back in style, in the game action fans have been waiting for.', 'Overwhelmingly Positive', '86176', '2019-03-08', 'CAPCOM Co., Ltd.', 'CAPCOM Co., Ltd.', '124.00');

INSERT INTO `games` (`game_id`, `title`, `img_src`, `desc`, `rating`, `rating_num`, `release_date`, `developer`, `publisher`, `price`) VALUES 
('329050', 'Devil May Cry 4 Special Edition', 'https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/329050/header.jpg?t=1644282580', 'The smash-hit stylish action game DMC4 is back and better than ever, boasting new playable characters and game modes!', 'Very Positive', '12222', '2015-06-23', 'CAPCOM Co., Ltd.', 'CAPCOM Co., Ltd.', '89.00');

INSERT INTO `games` (`game_id`, `title`, `img_src`, `desc`, `rating`, `rating_num`, `release_date`, `developer`, `publisher`, `price`) VALUES 
('582010', 'Monster Hunter: World', 'https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/582010/header.jpg?t=1711328912', 'Welcome to a new world! In Monster Hunter: World, the latest installment in the series, you can enjoy the ultimate hunting experience, using everything at your disposal to hunt monsters in a new world teeming with surprises and excitement.', 'Very Positive', '274750', '2018-08-09', 'CAPCOM Co., Ltd.', 'CAPCOM Co., Ltd.', '98.00');

INSERT INTO `games` (`game_id`, `title`, `img_src`, `desc`, `rating`, `rating_num`, `release_date`, `developer`, `publisher`, `price`) VALUES 
('1196590', 'Resident Evil Village', 'https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/1196590/header.jpg?t=1719197703', 'Experience survival horror like never before in the 8th major installment in the Resident Evil franchise - Resident Evil Village. With detailed graphics, intense first-person action and masterful storytelling, the terror has never felt more realistic.', 'Overwhelmingly Positive', '74839', '2021-05-07', 'CAPCOM Co., Ltd.', 'CAPCOM Co., Ltd.', '163.00');

INSERT INTO `games` (`game_id`, `title`, `img_src`, `desc`, `rating`, `rating_num`, `release_date`, `developer`, `publisher`, `price`) VALUES 
('203160', 'Tomb Raider', 'https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/203160/header.jpg?t=1710446431', 'Tomb Raider explores the intense origin story of Lara Croft and her ascent from a young woman to a hardened survivor.', 'Overwhelmingly Positive', '145776', '2013-03-05', 'Crystal Dynamics, Eidos-Montréal, Feral Interactive (Mac), Nixxes', 'Crystal Dynamics, Feral Interactive (Mac)', '49.00');

INSERT INTO `games` (`game_id`, `title`, `img_src`, `desc`, `rating`, `rating_num`, `release_date`, `developer`, `publisher`, `price`) VALUES 
('391220', 'Rise of the Tomb Raider™', 'https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/391220/header.jpg?t=1709834259', 'Rise of the Tomb Raider: 20 Year Celebration includes the base game and Season Pass featuring all-new content. Explore Croft Manor in the new “Blood Ties” story, then defend it against a zombie invasion in “Lara’s Nightmare”.', 'Very Positive', '103154', '2016-02-10', 'Crystal Dynamics, Eidos-Montréal, Feral Interactive (Mac), Feral Interactive (Linux), Nixxes', 'Crystal Dynamics, Feral Interactive (Mac), Feral Interactive (Linux)', '99.00');

INSERT INTO `games` (`game_id`, `title`, `img_src`, `desc`, `rating`, `rating_num`, `release_date`, `developer`, `publisher`, `price`) VALUES 
('550', 'Left 4 Dead 2', 'https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/550/header.jpg?t=1724971542', 'Set in the zombie apocalypse, Left 4 Dead 2 (L4D2) is the highly anticipated sequel to the award-winning Left 4 Dead, the #1 co-op game of 2008. This co-operative action horror FPS takes you and your friends through the cities, swamps and cemeteries of the Deep South, from Savannah to New Orleans across five expansive campaigns.', 'Overwhelmingly Positive', '667924', '2009-11-17', 'Valve', 'Valve', '26.75');

INSERT INTO `games` (`game_id`, `title`, `img_src`, `desc`, `rating`, `rating_num`, `release_date`, `developer`, `publisher`, `price`) VALUES 
('374320', 'DARK SOULS™ III', 'https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/374320/header.jpg?t=1700587390', 'Dark Souls continues to push the boundaries with the latest, ambitious chapter in the critically-acclaimed and genre-defining series. Prepare yourself and Embrace The Darkness!', 'Very Positive', '248763', '2016-04-12', 'FromSoftware, Inc.', 'FromSoftware, Inc., Bandai Namco Entertainment', '170.00');

INSERT INTO `games` (`game_id`, `title`, `img_src`, `desc`, `rating`, `rating_num`, `release_date`, `developer`, `publisher`, `price`) VALUES 
('524220', 'NieR:Automata™', 'https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/524220/header.jpg?t=1724998626', 'NieR: Automata tells the story of androids 2B, 9S and A2 and their battle to reclaim the machine-driven dystopia overrun by powerful machines.', 'Very Positive', '96863', '2017-03-17', 'Square Enix, PlatinumGames Inc.', 'Square Enix', '169.00');

INSERT INTO `games` (`game_id`, `title`, `img_src`, `desc`, `rating`, `rating_num`, `release_date`, `developer`, `publisher`, `price`) VALUES 
('1238810', 'Battlefield™ V', 'https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/1238810/header.jpg?t=1701356409', 'This is the ultimate Battlefield V experience. Enter mankind’s greatest conflict with the complete arsenal of weapons, vehicles, and gadgets plus the best customization content of Year 1 and 2.', 'Mostly Positive', '195628', '2018-11-09', 'DICE', 'Electronic Arts', '159.00');

INSERT INTO `games` (`game_id`, `title`, `img_src`, `desc`, `rating`, `rating_num`, `release_date`, `developer`, `publisher`, `price`) VALUES 
('1144200', 'Ready or Not', 'https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/1144200/header.jpg?t=1720713454', 'Ready or Not is an intense, tactical, first-person shooter that depicts a modern-day world in which SWAT police units are called to defuse hostile and confronting situations.', 'Very Positive', '150180', '2023-12-14', 'VOID Interactive', 'VOID Interactive', '100.00');

INSERT INTO `games` (`game_id`, `title`, `img_src`, `desc`, `rating`, `rating_num`, `release_date`, `developer`, `publisher`, `price`) VALUES 
('1659420', 'UNCHARTED™: Legacy of Thieves Collection', 'https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/1659420/header.jpg?t=1717621447', 'Play as Nathan Drake and Chloe Frazer in their own standalone adventures as they confront their pasts and forge their own legacies. This game includes the critically acclaimed single-player stories from both UNCHARTED 4: A Thief’s End and UNCHARTED: The Lost Legacy.', 'Very Positive', '14452', '2022-10-19', 'Naughty Dog LLC, Iron Galaxy Studios', 'PlayStation Publishing LLC', '209.00');

INSERT INTO `games` (`game_id`, `title`, `img_src`, `desc`, `rating`, `rating_num`, `release_date`, `developer`, `publisher`, `price`) VALUES 
('238320', 'Outlast', 'https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/238320/header.jpg?t=1666817106', "Hell is an experiment you can\'t survive in Outlast, a first-person survival horror game developed by veterans of some of the biggest game franchises in history. As investigative journalist Miles Upshur, explore Mount Massive Asylum and try to survive long enough to discover its terrible secret... if you dare.	", 'Overwhelmingly Positive', '86472', '2013-09-04', 'Red Barrels', 'Red Barrels', '49.00');

INSERT INTO `games` (`game_id`, `title`, `img_src`, `desc`, `rating`, `rating_num`, `release_date`, `developer`, `publisher`, `price`) VALUES 
('414700', 'Outlast 2', 'https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/414700/header.jpg?t=1618944453', 'Outlast 2 introduces you to Sullivan Knoth and his followers, who left our wicked world behind to give birth to Temple Gate, a town, deep in the wilderness and hidden from civilization. Knoth and his flock are preparing for the tribulations of the end of times and you’re right in the thick of it.', 'Very Positive', '43443', '2017-04-25', 'Red Barrels', 'Red Barrels', '72.00');

INSERT INTO `games` (`game_id`, `title`, `img_src`, `desc`, `rating`, `rating_num`, `release_date`, `developer`, `publisher`, `price`) VALUES 
('448510', 'Overcooked', 'https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/448510/header.jpg?t=1718290586', 'Overcooked is a chaotic couch co-op cooking game for one to four players. Working as a team, you and your fellow chefs must prepare, cook and serve up a variety of tasty orders before the baying customers storm out in a huff.', 'Very Positive', '11706', '2016-08-04', 'Ghost Town Games Ltd.', 'Team17 Digital Ltd', '39.00');

INSERT INTO `games` (`game_id`, `title`, `img_src`, `desc`, `rating`, `rating_num`, `release_date`, `developer`, `publisher`, `price`) VALUES 
('728880', 'Overcooked! 2', 'https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/728880/header.jpg?t=1723622537', 'Overcooked returns with a brand-new helping of chaotic cooking action! Journey back to the Onion Kingdom and assemble your team of chefs in classic couch co-op or online play for up to four players. Hold onto your aprons… it’s time to save the world again!', 'Very Positive', '47131', '2018-08-08', 'Ghost Town Games Ltd., Team17', 'Team17', '59.00');

INSERT INTO `games` (`game_id`, `title`, `img_src`, `desc`, `rating`, `rating_num`, `release_date`, `developer`, `publisher`, `price`) VALUES 
('1432860', 'Sun Haven', 'https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/1432860/header.jpg?t=1722663018', 'Build your farm and relationships with townsfolk, or forge ahead on a quest of magic, monsters, and dragons. Level up through a skill tree in 8 person multiplayer, or adventure solo!', 'Very Positive', '16720', '2023-03-11', 'Pixel Sprout Studios', 'Pixel Sprout Studios', '61.00');

INSERT INTO `games` (`game_id`, `title`, `img_src`, `desc`, `rating`, `rating_num`, `release_date`, `developer`, `publisher`, `price`) VALUES 
('1672500', 'GUNDAM BREAKER 4', 'https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/1672500/header.jpg?t=1725418290', 'Create your own ultimate Gundam in the newest Gundam Breaker! With more customizable parts than ever before, you finally have the freedom to build your perfect Gunpla. Test it in battle using the brand new dual-weapon system and break parts off of your enemies and add them to your collection.', 'Very Positive', '1800', '2024-08-29', 'CRAFTS ＆ MEISTER Co., Ltd', 'Bandai Namco Entertainment Inc.', '199.00');

INSERT INTO `users` (`username`, `email`, `password`) VALUES 
('chan', 'chan@example.com', 'chan'),
('teoh', 'teoh@example.com', 'teoh'),
('Nicholas', 'nicholas@example.com', 'Nicholas');

INSERT INTO `emails` (`user_id`, `email`, `salutation`, `purpose`, `subject`, `message`) VALUES 
(1, 'jinz1083@1utar.my', 'Mr', 'complaint', 'testing', 'abababc, assignment endanger both our mental and physical health.'),
(2, 'teohwh@gmail.com', 'Mr', 'complaint', 'WAD Assignment', 'Miss can extend deadline ah?'),
(3, 'Nic@gmail.com', 'Mr', 'complaint', 'mock data 101', 'https://youtu.be/hVxXhdfT4m0?feature=shared');

INSERT INTO `purchases` (`purchase_id`, `user_id`, `purchase_date`, `total_amount`, `payment_method`) VALUES 
('1', '1', '2024-09-05 22:50:57', '26.75', 'Credit card'),
('2', '2', '2024-09-03 22:52:24', '285.00', 'Touch n go'),
('3', '3', '2024-09-02 22:54:40', '12.00', 'Touch n go');

INSERT INTO `purchase_items` (`purchase_item_id`, `purchase_id`, `game_id`) VALUES 
('1', '1', '105600'),
('2', '2', '814380'),
('3', '3', '3590');