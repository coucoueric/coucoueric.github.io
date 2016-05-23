# to run this powershell:  .\AddNotepadppAlias
function AddNotepadppAlias 
{
	$currentalias = [bool](Get-Alias -Name npp -ErrorAction SilentlyContinue)
	if ($currentalias -eq $false)
	{
		New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT
		#no manually set notepad++ path
		if ($npp_path -eq $null)
		{
			$npp_path = (Get-ItemProperty -Path HKCR:\Notepad++_file\shell\open\command).'(default)'.Split('"%1"')[1]
		}

		#check again
		if ($npp_path -ne $null)
		{
			$newalias = "`n`nset-alias npp " + '"' + $npp_path  +'"'
			add-content -path $profile $newalias
			. $profile
			write-host "Added Notepad++ alias as npp"
		}

		#no luck
		else
		{
			write-host "Couldn't find Notepad++, please set $npp_path and run this function again"
		}
	}
}