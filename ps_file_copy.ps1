$smartboards = Import-Csv c:\smartboards.csv
$log_file = "c:\bulk_copy_log.txt"
$destination = "Covid19Videos"
$source = "C:\Covid19Videos\*.*"

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
                        New-Item -Path \\$smartboardx\c$\Users\Public\Desktop\Covid19Videos -ItemType directory
                        Copy-Item $source  \\$smartboardx\$destination
                        Add-Content $log_file "Files succesfully copied to $smartboardx"
                        shutdown /s /m \\$smartboardx /t 0
                    }
                  else
                    {
                        Add-Content $log_file "The folder named $destination already exist at $smartboardx"
                    }

            }
            else
            {
                Add-Content $log_file "It seems $smartboardx isn't available"
            }

    }
