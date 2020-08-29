$smartboards = Import-Csv c:\csv_file_name.csv 
$log_file = "c:\log_file_name.txt" 
$destination_folder = "destination_folder_name" 
$source_folder = "C:\source_folder_name" 

#creates a log file if it does not exist
$check_log_file = Test-Path -path $log_file 
if(-Not $check_log_file) 
    { 
        New-Item $log_file -ItemType File 
    } 

Add-Content $log_file "----------------------File copying process has just started----------------------" 

foreach($smartboard in $smartboards) 
    { 
        $smartboardx = $smartboard.name
        
        #return true value if the computer is reachable
        $is_computer_available = Test-Path -path "\\$smartboardx\c$\Users\Public\Desktop\" 
        
        #returns true value if the folder exist in the destination
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
