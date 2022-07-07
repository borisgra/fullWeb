:: !!!! pg_dump version >=13/0   !!!
:: DATABASE_URL_pg=postgres://zbabvnmflnvrim:ad140f14dd080d94bd459f21487653c6b52ba46969743172d2e08ebf70380a5f@ec2-54-155-226-153.eu-west-1.compute.amazonaws.com:5432/dhdm74g6dliir
:: ad140f14dd080d94bd459f21487653c6b52ba46969743172d2e08ebf70380a5f

:: DATABASE_URL_m=postgres://kslnpybeowjkvg:3f6b4bdf760a51a98b98903c08b062f7a35b0829fccac6525b8f22f0f5a9804a@ec2-54-155-99-116.eu-west-1.compute.amazonaws.com:5432/d5d0fmre4pphpd
:: 3f6b4bdf760a51a98b98903c08b062f7a35b0829fccac6525b8f22f0f5a9804a

cd "F:\pgsql_13.0-1"  & :: foldel PGSQL

:: "bin/pg_dump.exe" --file "herokuPG_20220219.backup" --format=c -c --host "ec2-54-155-226-153.eu-west-1.compute.amazonaws.com" --port "5432" -U "zbabvnmflnvrim" -E UTF-8 -v dhdm74g6dliir
"bin/pg_restore.exe" --host "ec2-54-155-99-116.eu-west-1.compute.amazonaws.com" --port "5432" --username kslnpybeowjkvg --dbname "d5d0fmre4pphpd" --verbose "herokuPG_20220219.sql"

:: "bin/pg_dump.exe" --file "herokuPG_20220219.sql" -c -S kslnpybeowjkvg --inserts --column-inserts --host "ec2-54-155-226-153.eu-west-1.compute.amazonaws.com" --port "5432" -U "zbabvnmflnvrim" -E UTF-8 -v dhdm74g6dliir

pause