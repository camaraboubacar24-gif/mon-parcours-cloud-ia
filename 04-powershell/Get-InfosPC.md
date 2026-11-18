# Get-InfosPC

Mon premier script. Au travail, je dois souvent vérifier un PC avant de le remettre à quelqu'un : son nom, son modèle, sa version de Windows, sa RAM et l'espace disque. Ce script me donne tout ça d'un coup, et il affiche en rouge un disque presque plein.

## Pour le lancer
```powershell
.\Get-InfosPC.ps1
```

## Ce que j'ai appris en l'écrivant
Les variables, `Get-CimInstance`, `Write-Host`, une boucle `foreach` et un `if / else`. Je l'ai fait avec l'aide de l'IA, puis je l'ai testé et je me suis assuré de comprendre chaque ligne.
