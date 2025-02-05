-- https://en.wikibooks.org/wiki/SQL_Exercises/Pieces_and_providers
    show databases;
    use hardware;
    show tables;
    select * from pieces;
    select * from providers;
    select * from provides;

-- 5.1 Select the name of all the pieces.
    select name from pieces;
-- 5.2  Select all the providers' data.
    select * from providers;
-- 5.3 Obtain the average price of each piece (show only the piece code and the average price).
    select piece,avg(price)
    from provides
    group by piece;
-- or
select b.code,avg(price)
from provides a
join pieces b
on
    a.piece =b.code
group by code



-- 5.4  Obtain the names of all providers who supply piece 1.
select name
from providers a
join provides b
on
    a.code = b.provider
where piece = 1;

-- 5.5 Select the name of pieces provided by provider with code "HAL".
    select a.name
    from pieces a
    join provides b
    on
        a.code =b.piece
    where b.provider ='HAL';

-- 5.6
-- ---------------------------------------------
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- Interesting and important one.
-- For each piece, find the most expensive offering of that piece and include the piece name, provider name, and price
    select pieces.name,providers.name,price
    from pieces
    inner join provides
    on pieces.code = piece
    inner join providers
    on providers.code = provider
    where price =
          (select max(price) from provides
                where piece = pieces.code);
-- (note that there could be two providers who supply the same piece at the most expensive price).
-- ---------------------------------------------
-- 5.7 Add an entry to the database to indicate that "Skellington Supplies" (code "TNBC") will provide sprockets (code "1") for 7 cents each.
INSERT INTO Provides(Piece, Provider, Price) VALUES (1, 'TNBC', 7);
-- 5.8 Increase all prices by one cent.
    update provides
    set price = price +1;
-- 5.9 Update the database to reflect that "Susan Calvin Corp." (code "RBT") will not supply bolts (code 4).
delete from provides
where provider ='RBT' and piece = 4;
-- 5.10 Update the database to reflect that "Susan Calvin Corp." (code "RBT") will not supply any pieces
    delete from provides
    where provider = 'RBT';
-- (the provider should still remain in the database).
