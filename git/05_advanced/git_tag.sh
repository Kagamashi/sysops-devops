# tags in Git are used to mark specific points in repository history, often used for releases
# tags are similar to branches but they don't change

# create a tag
git tag [tag_name]

# push tags to remote repository
git push origin [tag_name]

# push all tags at once
git push origin --tags

# list all tags in your repository
git tag


## ANNOTATED TAGS
# Annotated tags store additional information such as the tagger's name, email, message
# These are recommended when you want a permanent record associated with the tag, like release notes
git tag -a [tag_name] -m "Tag message"
git tag -a v1.0.0 -m "Release version 1.0.0"

# view details of annotated tag
git show [tag_name]
