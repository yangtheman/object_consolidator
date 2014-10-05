# Consolidate two objects to one

Given an array of objects with the following attributes,

```
  [
    { oid: 'a', quantity: 4 },
    { oid: 'b', quantity: 3 }
  ]
```

and this map:

```
  MAP = { ['a', 'b'] => 'z' }

```

Combine the two up to the maximum pair and replace it with target object.

The above example should result in the following objects:

```
  [
    { oid: 'a', quantity: 1 },
    { oid: 'z', quantity: 3 }    
  ]
```
