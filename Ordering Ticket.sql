-- DDL COMMAND

-- create database
create database tiket_kai;

-- use database
use tiket_kai;

-- create table detail_kereta
create table d_kereta(
	id_kelas varchar(15) not null,
	kelas varchar(15),
	primary key(id_kelas));

-- create table penumpang
create table penumpang(
	id_penumpang varchar(16) not null primary key,
	nama_penumpang varchar(30) not null,
	kategori varchar(15),
	jenis_identitas varchar(15));

-- create table kereta
create table kereta(
	no_kereta varchar(10) not null,
	nama_kereta varchar(30),
	id_kelas varchar(15),
	stasiun_keberangkatan varchar(50),
	stasiun_tujuan varchar(50),
	jam_keberangkatan time,
	jam_kedatangan time,
	primary key(no_kereta),
	constraint fk_kereta_d_kereta
		foreign key(id_kelas) references d_kereta(id_kelas)
);
	
-- create table pesanan
create table pesanan(
	kode_booking varchar(15) not null,
	no_pesanan varchar(15) not null,
	no_kereta varchar(5),
	tanggal date,
	primary key(kode_booking),
	constraint fk_pesanan_kereta
		foreign key(no_kereta) references kereta(no_kereta)
);

-- create table d_pesanan
create table d_pesanan(
	id_penumpang varchar(16),
	kode_booking varchar(15),
	gerbong varchar(15),
	no_kursi varchar(5),
	constraint fk_d_pesanan_penumpang
		foreign key(id_penumpang) references penumpang(id_penumpang),
	constraint fk_d_pesanan_pesanan
		foreign key(kode_booking) references pesanan(kode_booking)
);

-- DML COMMAND

-- insert into penumpang table
insert into penumpang(
	id_penumpang, nama_penumpang, 
	kategori, jenis_identitas) 
	values
	('xxxxxxxxxxxxx123', 'Satria Putra',
	'Dewasa', 'Kartu Identitas'),
	('xxxxxxxxxxxxx456', 'Pryadi rahmat',
	'Dewasa', 'Kartu Identitas'),
	('xxxxxxxxxxxxx789', 'Dwi Permata',
	'Dewasa', 'Kartu Identitas'),
	('xxxxxxxxxxxxx321', 'Retta',
	'Dewasa', 'Kartu Identitas');

-- insert data into d_kereta table
insert into d_kereta(
	id_kelas, kelas)
	values
	('K01', 'Ekonomi');

-- insert data into kereta table
insert into kereta(
	no_kereta, nama_kereta, id_kelas,
	stasiun_keberangkatan,
	stasiun_tujuan, jam_keberangkatan,
	jam_kedatangan)
	values (
	'258', 'Jaka Tingkir', 'K01',
	'Stasiun Senen', 'Stasiun Klaten',
	"00:12:55", "00:21:08");

-- update value no kereta
update kereta 
set no_kereta = 'xx8'
	where no_kereta = '258';

-- insert data into pesanan table
insert into pesanan(
	kode_booking, no_pesanan,
	no_kereta, tanggal)
	values(
	'6xxxxxT', '0xxxxxxx5', 'xx8', "2022-06-05");
	
-- insert data into detail pesanan
insert into d_pesanan(
	id_penumpang, kode_booking,
	gerbong, no_kursi)
	values
	('xxxxxxxxxxxxx123', '6xxxxxT',
	'Ekonomi', '01C'),
	('xxxxxxxxxxxxx456', '6xxxxxT',
	'Ekonomi', '01D'),
	('xxxxxxxxxxxxx789', '6xxxxxT',
	'Ekonomi', '02C'),
	('xxxxxxxxxxxxx321', '6xxxxxT',
	'Ekonomi', '02D');

-- DQL COMMAND

select  dk.id_kelas, dk.kelas, p.nama_penumpang, 
		p.kategori, dp.no_kursi
from kereta k 
join d_kereta dk on k.id_kelas = dk.id_kelas 
join pesanan ps on ps.no_kereta = k.no_kereta 
join d_pesanan dp on dp.kode_booking = ps.kode_booking 
join penumpang p on p.id_penumpang = dp.id_penumpang;

