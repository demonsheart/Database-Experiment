# ACS存取车辆的地点
create table acs_centers
(
    loc_id           int          not null,
    street_address   varchar(100) not null,
    telephone_number varchar(20)  not null,
    constraint locations_pk
        primary key (loc_id)
);

# 用户信息表
create table customers
(
    cus_id          int                       not null,
    last_name       varchar(20)               not null,
    first_name      varchar(20)               not null,
    hometown        varchar(50)               not null,
    cell_phone      varchar(20)               not null,
    email           varchar(50)               not null,
    credit_card     varchar(20)               null,
    is_student      boolean                   not null,
    license_number  varchar(20)               null,
    license_state   enum ('valid', 'invalid') null,
    expiration_date date                      null,
    constraint customers_pk
        primary key (cus_id)
);

# 用户密码表
create table cus_pw
(
    cp_id    int         not null auto_increment,
    cus_id   int         not null,
    password varchar(50) not null,
    constraint cus_pw_pk
        primary key (cp_id),
    constraint cus_pw_fk
        foreign key (cus_id) references customers (cus_id)
);

# 用户token表 维护登录状态 每次执行登录操作需要更新
create table cus_token
(
    ct_id  int         not null auto_increment,
    cus_id int         not null,
    token  varchar(50) not null,
    constraint cus_token_pk
        primary key (ct_id),
    constraint cus_token_fk
        foreign key (cus_id) references customers (cus_id)
);

# 罚款/违规信息
create table punishments
(
    punish_id   int auto_increment,
    cus_id      int      not null,
    create_time datetime not null,
    description text     not null,
    constraint punishments_pk
        primary key (punish_id),
    constraint punishments_fk
        foreign key (cus_id) references customers (cus_id)
);

# 车辆信息
create table cars
(
    car_id         int         not null,
    make           varchar(20) not null,
    model          varchar(30) not null,
    price_per_hour float       not null,
    price_per_day  float       not null,
    capacity       int         not null,
    constraint cars_pk
        primary key (car_id)
);

# 租车信息
create table rentals
(
    rental_id       int auto_increment,
    cus_id          int                  not null,
    car_id          int                  not null,
    pick_up_loc_id  int                  not null,
    drop_off_loc_id int                  not null,
    start_time      datetime             not null,
    billed_type     enum ('hour', 'day') not null,
    billed_count    int                  not null,
    constraint rentals_pk
        primary key (rental_id),
    constraint rentals_car_fk
        foreign key (car_id) references cars (car_id),
    constraint rentals_cus_fk
        foreign key (cus_id) references customers (cus_id),
    constraint rentals_drop_fk
        foreign key (drop_off_loc_id) references acs_centers (loc_id),
    constraint rentals_pick_fk
        foreign key (pick_up_loc_id) references acs_centers (loc_id)
);


