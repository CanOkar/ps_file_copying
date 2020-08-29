$smartboards = Import-Csv c:\smartboards.csv 

$log_file = "c:\bulk_copy_log.txt" 

$destination_folder = "Covid19Videos" 

$source_folder = "C:\Covid19Videos" 

$check_log_file = Test-Path -path $log_file 

  

  

if(-Not $check_log_file) 

    { 

        New-Item $log_file -ItemType File 

    } 

Add-Content $log_file "----------------------File copying process has just started----------------------" 

foreach($smartboard in $smartboards) 

    { 

        $smartboardx = $smartboard.name 

        $is_computer_available = Test-Path -path "\\$smartboardx\c$\Users\Public\Desktop\" 

        $path = Test-Path -path "\\$smartboardx\c$\Users\Public\Desktop\$destination_folder" 

         

        if($is_computer_available) 

            { 

                if(-Not $path) 

                    { 

                        New-Item -Path \\$smartboardx\c$\Users\Public\Desktop\$destination_folder -ItemType directory 

                        Copy-Item $source_folder\*.*  \\$smartboardx\C$\Users\public\desktop\$destination_folder 

                        Add-Content $log_file "Files succesfully copied to $smartboardx" 

                        shutdown /s /m \\$smartboardx /t 0 

                    } 

                  elseif($path) 

                    { 

                        Add-Content $log_file "The folder named $destination_folder already exist at $smartboardx" 

                        shutdown /s /m \\$smartboardx /t 0 

                    } 

  

            } 

            else 

            { 

                Add-Content $log_file "It seems $smartboardx isn't available" 

            } 

  

    } 
