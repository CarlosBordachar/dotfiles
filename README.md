# dotfiles

dotFiles repository

## How to use

> [!important]
> Sobre este branch (master) NO realizar ningún commit de configs.

En cada branch se tiene la configuración para cada OS y DE.

## Undo pushed commits on this branch

``` bash
dotfiles rebase -i <hashCommitValido>
```

Nos abre la pantalla del rebase interactivo, y en los commits que deseamos desechar ponemos la letra "d" (drop).
Guardamos los cambios y salidos del interactivo.

Si nos llega a quedar en la mitad el rebase hacemos `dotfiles rebase --continue`

Pusheamos el branch con el rebase hecho, para lo cual debemos de forzar el push dado que estamos modificando la historia que ya estaba subida.

``` bash
dotfiles push --force origin master
```

Cabe aclarar que esta forma de modificar la historia ya subida no es recomendable hacerlo si estamos trabajando en un equipo, ya que otros usuarios tendrán problema si se bajaron anteriormente y trabajan sobre la historia/commits que ahora acabamos de eliminar.
