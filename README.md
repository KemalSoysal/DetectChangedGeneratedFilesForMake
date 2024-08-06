# DetectChangedForMake

This project is for developing a strategy to only build changed artifacts
when they are generated at a certain build stage.
If they stay the same after the next build, their compilation action can be skipped.

## Initial State is `nothing is built`.

In this case the hash file should not exist.
It also means that the hash file needs to be cleaned with the clean target.
The calculated hash will be saved in a file called `files.hash`.
All generated files have the youngest modification time.

## Next State is `some build took place`.

We have a `files.hash` with generated files hash.
We can recalculate the hash and check if it changed.
If it changed, then we can save the new hash into the hash file.
The build will correctly rebuild the artifacts from the auto 
files because their modification time is the youngest.

If the hash did not change, then we can reset the auto
generated files modification time to the modification
time of `files.hash`, because this was the last known 
time of change.
This will enable make to detect not yet built artifacts - if last build was kind of half way successful. 

