Config = {


        Jobs = {                                                        -- Lista dei prefissi targa che permettono di chiudere / aprire / depositare il veicolo

            ["pol"] = {"lspd","police","ambulance"},                                -- Inserisci i prefissi che hai scritto in prefix_plate ed i job autorizzati
            ["ems"] = {"ambulance","medici"}

        },

        KeyLock = "u",                                                      --Tasto che vuoi usare per far chiudere/aprire il veicolo (Ricorda che ognuno puo modificarlo nelle impostazioni)

        --Inizio Garage

        ["NomeGarage"] = {                                                  --Nome del garage (Appare nel menu)


            marker_config = {

                ritiro = {
                    show_marker = true,                                     --se vuoi che il marker sia visibile
                    intercation = true,
                    render_distance = 5.0,                                  --la distanza in cui vuoi che si inizi a vedere il marker
                    interaction_distance = 4.0,                             --la distanza in cui vuoi che si possa interagire con il marker
    
                    text_notify = true,                                     --se vuoi la notifica in alto a sinistra
    
                    text = "Premi [~g~E~w~] per ritirare il veicolo",           --testo della notifica
    
                    rgb = vec3(255, 255, 255),                              --colore del marker
                    type = 20,                                              --tipo di marker
                    scale = vec3(0.7, 0.7, 0.7),                            --dimensioni del marker
                },
                spawn =             {
                    show_marker = false,                                     --se vuoi che il marker sia visibile
                    intercation = false,
                    render_distance = 5.0,                                  --la distanza in cui vuoi che si inizi a vedere il marker
                    interaction_distance = 4.0,                             --la distanza in cui vuoi che si possa interagire con il marker
    
                    text_notify = false,                                     --se vuoi la notifica in alto a sinistra
    
                    text = "",                                              --testo della notifica
    
                    rgb = vec3(255, 255, 255),                              --colore del marker
                    type = 20,                                              --tipo di marker
                    scale = vec3(0.7, 0.7, 0.7),                            --dimensioni del marker
                },
                deposito =        {
                    show_marker = true,                                     --se vuoi che il marker sia visibile
                    intercation = true,
                    render_distance = 5.0,                                  --la distanza in cui vuoi che si inizi a vedere il marker
                    interaction_distance = 4.0,                             --la distanza in cui vuoi che si possa interagire con il marker
    
                    text_notify = true,                                     --se vuoi la notifica in alto a sinistra
                    text = "Premi [~g~E~w~] per depositare il veicolo",     --testo della notifica
    
                    rgb = vec3(255, 255, 255),                              --colore del marker
                    type = 20,                                              --tipo di marker
                    scale = vec3(0.7, 0.7, 0.7),                            --dimensioni del marker
                },
            },

            coords = {
                ritiro =        vec3(581.99456787109,2729.7507324219,42.06010055542),                   --coords marker ritiro
                spawn =         vec4(594.56665039063,2716.9694824219,41.99528503418,183.67610168457),    --coords spawn veicolo
                deposito =      vec3(604.27941894531,2736.2770996094,42.01420211792)                    --coords marker deposito
            },
            

            public = false,                                                   -- se il garage puo essere accessibile a tutti

            using_mxm_double_job = false,                                     -- se usi il sistema di double job di MaXxaM#0511  https://github.com/MaXxaM2611/mxm_doublejob

            jobsallowisted = {                                                -- Lista dei job che possono accedere al garage  ["nome-job"] = grado minimo che puo accedere
                ["police"] = 0,
                ["ambulance"] = 0,
                ["test"] = 1
            },

            vehicle_list = {                                                --Lista dei veicoli che possono essere prelevati dal garage

                ["blista"] = {                                              --Modello di spawn del veicolo
                    label = "Blista",                                       --Nome del veicolo che appare nel menu
                    limit = true,                                           --Se vuoi fissare un limite allo spawn dei veicoli 
                    maxlimitspawn = 5,                                      --Limite dello spawn
                    veiclespawned = 0,                                      --Non Toccare si aggiorna da solo

                    color1 = vec3(255, 255, 0),                             --Colore Primario che vuoi dare al veicolo (se vuoi che sia random cancella la riga)
                    color2 = vec3(255, 255, 0),                             --Colore Secondario che vuoi dare al veicolo (se vuoi che sia random cancella la riga)
                    livery = 0                                              --Codice della livrea del veicolo (se vuoi che sia random cancella la riga)
                },

                ["rumpo"] = {                                               --Modello di spawn del veicolo
                    label = "Rumpo",                                        --Nome del veicolo che appare nel menu
                    limit = false,                                          --Se vuoi fissare un limite allo spawn dei veicoli 
                    maxlimitspawn = 10,                                     --Limite dello spawn
                    veiclespawned = 0,                                      --Non Toccare si aggiorna da solo

                    color1 = vec3(255, 255, 0),                             --Colore Primario che vuoi dare al veicolo (se vuoi che sia random cancella la riga)
                    color2 = vec3(255, 255, 0),                             --Colore Secondario che vuoi dare al veicolo (se vuoi che sia random cancella la riga)
                    livery = 0                                              --Codice della livrea del veicolo (se vuoi che sia random cancella la riga)
                },
     
            },

            prefix_plate = "POL",                                           -- PREFISSO targa [MAX 3 CARATTERI] ricorda di inserire il prefisso nella tabella Jobs in alto per autorizzare i job ad aprire e chiudere il veicolo

        },
            --Fine Garage


        --Per creare un altro garage copia ed incolla la tabella sopra e cambia i valori al suo interno

}