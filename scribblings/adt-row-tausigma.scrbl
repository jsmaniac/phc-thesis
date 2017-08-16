#lang scribble/manual

@require["util.rkt"
         "adt-utils.rkt"
         (for-label (only-meta-in 0 typed/racket))]
@(use-mathjax)

@title[#:style (with-html5 manual-doc-style)
       #:version (version-text)]{Types (with ρ)}

@cases["σ,τ" #:first-sep "⩴"
       @acase{…}
       @acase{@ctor[@κof[τ]]@tag*{constructor}} @; same
       @acase{@record[@ςf]@tag*{possibly row-polymorphic record}} @; changed
       @acase{@∀c[(@repeated{@ρc}) τ]@tag*{row-polymorphic abstraction (constructors)}} @; new
       @acase{@∀f[(@repeated{@ρf}) τ]@tag*{row-polymorphic abstraction (fields)}}] @; new

@; new↓

We further define variants as a subset of the unions allowed by @|typedracket|
(including unions of the constructors defined above). Variants are equivalent
to the union of their cases, but guarantee that pattern matching can always be
performed (for example, it is not possible in @|typedracket| to distinguish
the values of two function types present in the same union, and it is
therefore impossible to write a pattern matching expression which handles the
two cases differently). Additionally, constraints on the absence of some
constructors in the row type can be specified on variants.

@cases["σ,τ" #:first-sep "⩴"
       @acase{…}
       @acase{@variant[@ςf]@tag*{possibly row-polymorphic variant}}] @; new/changed

@cases[@ςc #:first-sep "⩴"
       @acase{@repeatset{@κof[τ]}@tag*{fixed constructors}}
       @acase{@|ρc|\ @repeatset{-@|κ|ᵢ}\ @repeatset{+@κof[ⱼ τⱼ]} @tag*{row without some ctors, with extra ctors}}]

@cases[@ςf #:first-sep "⩴"
       @acase{@repeatset{@|ɐ|:τ}@tag*{fixed fields}}
       @acase{@|ρf|\ @repeatset{-@|ɐ|ᵢ}\ @repeatset{+@|ɐ|ⱼ:τⱼ}@tag*{row without some fields, with extra fields}}]