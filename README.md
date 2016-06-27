# wikigen
wikigen is a minimal static wiki generator written in Haskell, with a focus on
performance and elegance (which is assumed to be synonymous with simplicity).

It is currently a work in progress, so ~~most~~all features aren't ready yet.
A basic overview of features and non-features:

* [ ] markdown as the only wiki format to avoid using pandoc (and thus half of
  hackage) and to minimize fragmentation. This can be also be implemented by
  using an optional dependency for a different format and a compatibility layer
  in the future if this turns out to be desired.
* [ ] as much as possible static content.
* [ ] editing through a (possibly remote) git repository and periodic
  regeneration.
* [ ] autolinking.
* [ ] wiki features people want: search, templating for the non-article part
  of each page etc.
* [ ] index generation and other necessities.
