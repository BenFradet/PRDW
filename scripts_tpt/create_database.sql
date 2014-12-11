/*==============================================================*/
/* DBMS name:      Teradata V13                                 */
/* Created on:     07/10/2014 17:25:13                          */
/*==============================================================*/


/*==============================================================*/
/* Table: carte_avantage                                        */
/*==============================================================*/
create table carte_avantage (
    id_carte_fidelite    numeric                        not null title 'Identifiant carte fidélité',
    cd_avantage          numeric                        not null title 'Code avantage',
    constraint pk_carte_avantage primary key (id_carte_fidelite, cd_avantage)
);

comment on table carte_avantage is 
'C''est le coupon que le client fait passer à la caisse afin de bénéficier d''un avantage donné. Il n''est utilisble qu''une seule fois et possée une période de validité';

/*==============================================================*/
/* Table: d_avantages_carte                                     */
/*==============================================================*/
create table d_avantages_carte (
    cd_avantage          numeric                        not null title 'Code avantage',
    id_carte_fidelite    numeric                        not null title 'Identifiant carte fidélité',
    constraint pk_d_avantages_carte primary key (cd_avantage, id_carte_fidelite)
);

comment on table d_avantages_carte is 
'Les avantages cartes';

/*==============================================================*/
/* Table: d_client                                              */
/*==============================================================*/
create table d_client (
    id_client            numeric                        not null title 'Identifiant client',
    id_foyer             numeric                        title 'Identifiant foyer',
    dt_naissance         date                           not null title 'Date de naissance',
    adresse_client       varchar(50)                    not null title 'Adresse client',
    nom_client           varchar(50)                    not null title 'Nom client',
    prenom_client        varchar(50)                    not null title 'Prénom client',
    constraint pk_d_client primary key (id_client)
);

comment on table d_client is 
'Il s''agit des individus ayant effectué des achats en magasin.';

/*==============================================================*/
/* Table: d_client_avantage                                     */
/*==============================================================*/
create table d_client_avantage (
    cd_avantage          numeric                        not null title 'Code avantage',
    cd_produit           varchar(13)                    not null title 'Code produit',
    nom_avantage         varchar(50)                    title 'Nom avantage',
    desc_avantage        long varchar                   title 'Description avantage',
    nbr_points_gagnes    smallint                       title 'Nombre de points gagnés',
    constraint pk_d_client_avantage primary key (cd_avantage)
);

comment on table d_client_avantage is 
'Il s''agit d''une avantage sur des familles de produits, permettent de gagner des points sur le compte fidélité.';

/*==============================================================*/
/* Table: d_client_carte_fidelite                               */
/*==============================================================*/
create table d_client_carte_fidelite (
    id_carte_fidelite    numeric                        not null title 'Identifiant carte fidélité',
    nbr_points           smallint                       title 'Nombre de points',
    dt_prem_achat_carte  date                           title 'Date premier achat carte fidélite',
    dt_dern_achat_carte  date                           title 'Date dernier achat carte fidélité',
    constraint pk_d_client_carte_fidelite primary key (id_carte_fidelite)
);

comment on table d_client_carte_fidelite is 
'Contient des informations (type de carte, dernier achat, etc..) relatives à la carte de fidélité des clients';

/*==============================================================*/
/* Table: d_client_encarte                                      */
/*==============================================================*/
create table d_client_encarte (
    id_client            numeric                        not null title 'Identifiant client',
    id_carte_fidelite    numeric                        not null title 'Identifiant carte fidélité',
    constraint pk_d_client_encarte primary key (id_client, id_carte_fidelite)
);

comment on table d_client_encarte is 
'Les clients poccesseurs de carte';

/*==============================================================*/
/* Table: d_client_foyer                                        */
/*==============================================================*/
create table d_client_foyer (
    id_foyer             numeric                        not null title 'Identifiant foyer',
    nbr_personnes        numeric(2)                     title 'Nombre de personnes',
    nbr_enfants          numeric(2)                     title 'Nombre d’enfants',
    dt_prem_achat_foyer  date                           title 'Date premier achat foyer',
    dt_dern_achat_foyer  date                           title 'Date dernier achat foyer',
    adresse_foyer        varchar(50)                    title 'Adresse foyer',
    constraint pk_d_client_foyer primary key (id_foyer)
);

comment on table d_client_foyer is 
'Il s''agit d''un groupe de personnes lié par une adresse commune. Il y a au minimum deux personnes dans un foyer';

/*==============================================================*/
/* Table: d_magasin                                             */
/*==============================================================*/
create table d_magasin (
    id_magasin           numeric                        not null title 'Identifiant magasin',
    id_chaine            numeric                        not null title 'Identifiant chaine',
    nom_magasin          varchar(50)                    title 'Nom magasin',
    dt_ouverture         date                           title 'Date d’ouverture',
    surface              decimal(5,2),
    nb_rayons            numeric(2)                     title 'Nombre de rayons',
    nb_caisses           numeric(2)                     title 'Nombre de caisses',
    adresse_magasin      varchar(50)                    title 'Adresse magasin',
    constraint pk_d_magasin primary key (id_magasin)
);

comment on table d_magasin is 
'Contient les caractéristiques du magasin';

/*==============================================================*/
/* Table: d_magasin_chaine                                      */
/*==============================================================*/
create table d_magasin_chaine (
    id_chaine            numeric                        not null title 'Identifiant chaine',
    id_zone              numeric                        not null title 'Identifiant zone',
    nom_chaine           varchar(50)                    title 'Nom chaine',
    constraint pk_d_magasin_chaine primary key (id_chaine)
);

comment on table d_magasin_chaine is 
'Nom de la chaîne à laquelle appartient le magasin';

/*==============================================================*/
/* Table: d_magasin_entr                                        */
/*==============================================================*/
create table d_magasin_entr (
    id_entreprise        numeric                        not null title 'Identifiant entreprise',
    nom_entreprise       varchar(50)                    title 'Nom entreprise',
    constraint pk_d_magasin_entr primary key (id_entreprise)
);

comment on table d_magasin_entr is 
'Nom de l''entreprise propriétaire du magasin';

/*==============================================================*/
/* Table: d_magasin_zone                                        */
/*==============================================================*/
create table d_magasin_zone (
    id_zone              numeric                        not null title 'Identifiant zone',
    id_entreprise        numeric                        not null title 'Identifiant entreprise',
    nom_zone             varchar(50)                    title 'Nom zone',
    constraint pk_d_magasin_zone primary key (id_zone)
);

comment on table d_magasin_zone is 
'Zone où se trouve le magasin';

/*==============================================================*/
/* Table: d_produit                                             */
/*==============================================================*/
create table d_produit (
    cd_produit           varchar(13)                    not null title 'Code produit',
    id_rayon             numeric                        not null title 'Identifiant rayon',
    id_famille           numeric                        not null title 'Identifiant famille',
    id_sous_famille      numeric                        not null title 'Identifiant sous-famille',
    desc_produit         long varchar                   title 'Description produit',
    tva                  decimal(5,2),
    prix_achat           decimal(5,2)                   title 'Prix achat',
    prix_vente_ht        decimal(5,2)                   title 'Prix vente HT',
    prix_kilos           decimal(5,2)                   title 'Prix kilos',
    prix_vente_ttc       decimal(5,2)                   title 'Prix vente TTC',
    constraint pk_d_produit primary key (cd_produit)
);

comment on table d_produit is 
'Contient les caractéristiques des produits';

/*==============================================================*/
/* Table: d_produit_famille                                     */
/*==============================================================*/
create table d_produit_famille (
    id_rayon             numeric                        not null title 'Identifiant rayon',
    id_famille           numeric                        not null title 'Identifiant famille',
    desc_famille         long varchar                   title 'Description famille',
    constraint pk_d_produit_famille primary key (id_rayon, id_famille)
);

comment on table d_produit_famille is 
'Famille du produit';

/*==============================================================*/
/* Table: d_produit_rayon                                       */
/*==============================================================*/
create table d_produit_rayon (
    id_rayon             numeric                        not null title 'Identifiant rayon',
    desc_rayon           long varchar                   title 'Description rayon',
    constraint pk_d_produit_rayon primary key (id_rayon)
);

comment on table d_produit_rayon is 
'Rayon où se trouve le produit';

/*==============================================================*/
/* Table: d_produit_sous_fami                                   */
/*==============================================================*/
create table d_produit_sous_fami (
    id_rayon             numeric                        not null title 'Identifiant rayon',
    id_famille           numeric                        not null title 'Identifiant famille',
    id_sous_famille      numeric                        not null title 'Identifiant sous-famille',
    desc_sous_famille    long varchar                   title 'Description sous-famille',
    constraint pk_d_produit_sous_fami primary key (id_rayon, id_famille, id_sous_famille)
);

comment on table d_produit_sous_fami is 
'Sous-famille du produit
';

/*==============================================================*/
/* Table: f_ticket                                              */
/*==============================================================*/
create table f_ticket (
    num_ticket           numeric                        not null title 'Numéro de ticket',
    id_magasin           numeric                        not null title 'Identifiant magasin',
    moyen_paiement       numeric(1)                     not null title 'Moyen paiement',
    id_client            numeric                        not null title 'Identifiant client',
    dt_ticket            date                           title 'Date de ticket',
    heure                time,
    prix_total           decimal(5,2)                   title 'Prix total',
    constraint pk_f_ticket primary key (num_ticket)
);

comment on table f_ticket is 
'Contient la quantité de produits vendus à un client pour une date et une heure donnée';

/*==============================================================*/
/* Table: f_ticket_detail                                       */
/*==============================================================*/
create table f_ticket_detail (
    num_ticket           numeric                        not null title 'Numéro de ticket',
    cd_produit           varchar(13)                    not null title 'Code produit',
    quantite             numeric(2)                     not null,
    prix                 decimal(5,2),
    constraint pk_f_ticket_detail primary key (num_ticket)
);

comment on table f_ticket_detail is 
'Il s''agit d''une ligne de la table f_ticket. ';

/*==============================================================*/
/* Table: f_ticket_paiement                                     */
/*==============================================================*/
create table f_ticket_paiement (
    moyen_paiement       numeric(1)                     not null title 'Moyen paiement',
    libelle_paiement     char(10)                       title 'Libellé paiement',
    constraint pk_f_ticket_paiement primary key (moyen_paiement)
);

comment on table f_ticket_paiement is 
'Moyen de paiement utilisé par le client pour régler son ticket.';

alter table carte_avantage
    add constraint fk_carte_av_carte_ava_d_client foreign key (id_carte_fidelite)
       references d_client_carte_fidelite (id_carte_fidelite);

alter table d_avantages_carte
    add constraint fk_d_avanta_d_avantag_d_client foreign key (cd_avantage)
       references d_client_avantage (cd_avantage);

alter table d_client
    add constraint fk_d_client_client_fo_d_client foreign key (id_foyer)
       references d_client_foyer (id_foyer);

alter table d_client_avantage
    add constraint fk_d_client_avantage__d_produi foreign key (cd_produit)
       references d_produit (cd_produit);

alter table d_client_encarte
    add constraint fk_d_client_d_client__d_client foreign key (id_client)
       references d_client (id_client);

alter table d_magasin
    add constraint fk_d_magasi_avoir_cm_d_magasi foreign key (id_chaine)
       references d_magasin_chaine (id_chaine);

alter table d_magasin_chaine
    add constraint fk_d_magasi_avoir_zc_d_magasi foreign key (id_zone)
       references d_magasin_zone (id_zone);

alter table d_magasin_zone
    add constraint fk_d_magasi_avoir_ez_d_magasi foreign key (id_entreprise)
       references d_magasin_entr (id_entreprise);

alter table d_produit
    add constraint fk_d_produi_sous_fami_d_produi foreign key (id_rayon, id_famille, id_sous_famille)
       references d_produit_sous_fami (id_rayon, id_famille, id_sous_famille);

alter table d_produit_famille
    add constraint fk_d_produi_rayon_a_f_d_produi foreign key (id_rayon)
       references d_produit_rayon (id_rayon);

alter table d_produit_sous_fami
    add constraint fk_d_produi_famille_a_d_produi foreign key (id_rayon, id_famille)
       references d_produit_famille (id_rayon, id_famille);

alter table f_ticket
    add constraint fk_f_ticket_acheter_d_magasi foreign key (id_magasin)
       references d_magasin (id_magasin);

alter table f_ticket
    add constraint fk_f_ticket_posseder_d_client foreign key (id_client)
       references d_client (id_client);

alter table f_ticket
    add constraint fk_f_ticket_regler_pa_f_ticket foreign key (moyen_paiement)
       references f_ticket_paiement (moyen_paiement);

alter table f_ticket_detail
    add constraint fk_f_ticket_appartien_f_ticket foreign key (num_ticket)
       references f_ticket (num_ticket);

alter table f_ticket_detail
    add constraint fk_f_ticket_possede_d_produi foreign key (cd_produit)
       references d_produit (cd_produit);

