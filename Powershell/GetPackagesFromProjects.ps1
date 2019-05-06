#This will be the root folder of all your solutions - we will search all  children of this folder
$SOLUTIONROOT = "C:\WorkingSpace"

Function ListAllPackages ($BaseDirectory) {
    Write-Host "Starting Package List - This may take a few minutes ..."
    $PACKAGECONFIGS = Get-ChildItem -Recurse -Force $BaseDirectory -ErrorAction SilentlyContinue | 
    Where-Object { ($_.PSIsContainer -eq $false) -and ( $_.Name -eq "packages.config") }
    ForEach ($PACKAGECONFIG in $PACKAGECONFIGS) {
        $path = $PACKAGECONFIG.FullName
        [xml]$packages = Get-Content $path

        foreach ($package in $packages.packages.package) {
            $packageToGet = Find-Package -Source NugetV2 -Name $package.id -RequiredVersion $package.version -ErrorAction SilentlyContinue
            $Link = ($packageToGet.Links | Where-Object { $_.RelationShip -like "galleryDetails" }).HRef
            Add-Content -Value "$path, $($package.id), $($package.version), $Link" -Path "C:\temp\TheFile.csv"
        }
    }
}

ListAllPackages $SOLUTIONROOT