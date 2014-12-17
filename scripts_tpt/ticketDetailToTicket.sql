insert into DB_PRDW_CORE.f_ticket (
    num_ticket,
    id_magasin,
    moyen_paiement
)
select distinct (
    num_ticket,
    12,
    1
) from DB_PRDW_CORE.f_ticket_detail;

update DB_PRDW_CORE.f_ticket
set prix_total = (
    select sum(prix)
    from DB_PRDW_CORE.f_ticket_detail
    where f_ticket_detail.num_ticket = f_ticket.num_ticket
);
