acceder à mysql via le termianl éxécuter :

    -> mysql -u <username> -p

entrer le mot de passe demandé selon la configuration utilisateur/mot de passe avec laquelle vous souhaitez vous connecter.
une fois dans mysql éxécuter le script fourni dans CinemaNoAnot.sql

afin d'exporter le travail dans un fichier en local :

    -> exit
    -> mysqldump -u <username> -p eval_em_cinema > dumpcinema.sql

pour importer une base de donnée construite dans un fichier mysql vers un gestionnaire de BDD

    -> mysql -u <username> -p <nomDeLaBaseDeDonnée> < dumpcinema.sql
