# Info

Few simple environments to build docker containers in various methods.


# for expression

[for s in var.list : upper(s)]
- produces list
- s is temporary symbol

[for k, v in var.map : length(k) + length(v)]
- for map/object, k refers to key or attribute name
[for i, v in var.list : "${i} is ${v}"]
- for list/tupple, k is index of each element

for [key/index] - optional, element


# result
- [] - tuple
- {} - object, needs 2 expressions separated by =>


# filtering
via if

# grouping to avoid duplicates of keys
```
...
```
