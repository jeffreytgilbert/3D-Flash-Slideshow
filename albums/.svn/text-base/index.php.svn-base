<albums>
<?php
error_reporting(E_ALL);

// in apache, check LimitRequestBody
//exit;
define('BASEPATH', '.');
//include BASEPATH . '/source/globals/core.php';

// Open current directory
if($handle = opendir('./'))
{
	$x=0;
	// Loop through all files
	while(false !== ($file = readdir($handle)))
	{
		// Ignore hidden files
		if(!preg_match("/^\./", $file))
		{
			// Put dirs in $dirs[] and files in $files[]
			if(is_dir($file))
			{
				$dirs[$x] = $file;
				$x++;
			}
		}
	}
 
	// Close directory
	closedir($handle);
	
	// if $files[] exists, sort it and print all elements in it.
	if(is_array($dirs))
	{
		foreach($dirs as $x => $dir)
		{
?>
	<album title="<?php echo $dir ?>">
<?php
			if($handle = opendir($dir)){
				// Loop through all files
				while(false !== ($file = readdir($handle)))
				{
					// Ignore hidden files
					if(!preg_match("/^\./", $file))
					{
						$file_parts = explode('.',$file);
						
						// Put dirs in $dirs[] and files in $files[]
?>
		<photo src="albums/<?php echo $dir.'/'.$file ?>" showEveryPixel="false"> </photo>
<?php
					}
				}
			}
			closedir($handle);
?>
	</album>
<?php
		}
	}
}
?>
</albums>