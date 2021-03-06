#lang scribble/manual

@require["util.rkt"
         "adt-utils.rkt"
         scriblib/render-cond
         (for-label (only-meta-in 0 typed/racket))]
@(use-mathjax)

@title[#:style (with-html5 manual-doc-style)
       #:tag "adt-row-trules"
       #:version (version-text)]{Typing rules (with ρ)}

@todo{Should the filter be something else than @${ϵ|ϵ} or is the filter inferred
 via other rules when the ``function'' does not do anything special?}

@$inferrule[
 @${@Γ[⊢ e @R[τ φ⁺ φ⁻ o]]}
 @${@Γ[⊢ @ctore[@κe[e]] @R[@ctorτ[@κof[τ]] ϵ ⊥ ∅]]}
 @${@textsc{T-Ctor-Build}}]

@${@applyfilter} is defined
in@~cite[#:precision "p. 75" "tobin-hochstadt_typed_2010"].

@htodo{their second (p. 75) definition of applyfilter does not clearly state
 that ϵ in τ_ϵ means the empty path (actually, ϵ means an emtpy
 \overrightarrow{?} for any such sequence. Also, τ_π matches τ, with π = ϵ (and
 therefore τ_ϵ matches τ). So that's how Number|\overline{Number} gets processed
 with the updated applyfilter.}

@todo{Copy the definition of applyfilter.}

@$inferrule[@${@Γ[⊢ e @R[τ φ⁺ φ⁻ o]] \\
             φ⁺_r / φ⁻_r
             = @applyfilter(@ctorτ[@κof[⊤]]/\overline{@ctorτ[@κof[⊤]]}, τ, o)}
            @${@Γ[⊢ @${(@ctor-pred[@κ]\ e)} @R[Boolean φ⁺_r φ⁻_r ∅]]}
            @${@textsc{T-Ctor-Pred}}]

@(define & @cond-element[[latex "\\savedamp"] [else "&"]])
@(define nl @cond-element[[latex "\\csname @arraycr\\endcsname"] [else "\\\\"]])

@$inferrule[
 @${Γ ⊢ e : τ ; φ ; o \\ τ <: @ctorτ[@κ @${τ'}] \\
  o_r = @"\\left\\{" \begin{array}{rl}
  @πctor-val(π(x)) @& @textif o = π(x) @nl
  ∅ @& @otherwise
  \end{array}\right. \\
  φ_r
  = @applyfilter(\overline{\#f}_{@πctor-val}|\#f_{@πctor-val},
  τ, o)}
 @${Γ ⊢ (@ctor-val[@κ]\ e) : τ' ; φ_r ; o_r}
 #:wide 'latex
 @${@textsc{T-Ctor-Val}}]

@$inferrule[
 @${@repeated{Γ ⊢ eᵢ : τᵢ ; φᵢ ; oᵢ}}
 @${Γ ⊢ @recorde[@repeated{@|ɐ|ᵢ = eᵢ}]
  : @recordτ[@repeated{@|ɐ|ᵢ : τᵢ}]; ϵ|⊥ ; ∅}
 @${@textsc{T-Record-Build}}]

@$inferrule[
 @${Γ ⊢ e : τ ; φ ; o \\
  φ_r = @applyfilter(@recordτ[@repeated{@|ɐ|ᵢ : ⊤}]
  |\overline{@recordτ[@repeated{@|ɐ|ᵢ : ⊤}]}, τ, o)}
 @${Γ ⊢ (@record-pred[@repeated{@|ɐ|ᵢ}] e) : Boolean ; φ_r ; ∅}
 #:wide 'latex
 @${@textsc{T-Record-Pred}}]

@$inferrule[
 @${Γ ⊢ e : τ ; φ ; o \\ τ <: @recordτ[@repeated{@|ɐ|ᵢ : τᵢ} @ρf] \\ @; changed
  o_r = @"\\left\\{" \begin{array}{rl}
  @πɐ{@|ɐ|ⱼ}(π(x)) @& @textif o = π(x) @nl
  ∅ @& @otherwise
  \end{array}\right. \\
  φ_r
  = @applyfilter(\overline{\#f}_{@πɐ{@|ɐ|ⱼ}}|\#f_{@πɐ{@|ɐ|ⱼ}},
  τ, o)}
 @${Γ ⊢ e.@|ɐ|ⱼ : τ' ; φ_r ; o_r}
 #:wide 'latex
 @${@textsc{T-Record-GetField}}]

@$inferrule[
 @${
  Γ ⊢ e_{r} : τ_{r} ; φ_{r} ; o_{r} \\
  τ_{r} <: @recordτ[@repeated{@|ɐ|ᵢ : τ'ᵢ}
                    @${@ρf - \{@repeated{@|ɐ|'ⱼ}\}}]\\@;c
  Γ ⊢ e_{v} : τ_{v} ; φ_{v} ; o_{v} \\
  @|ɐ| ∉ \{@|ɐ|ᵢ\} \\
  @|ɐ| ∈ \{@repeated{@|ɐ|'ⱼ}\}
 }
 @${Γ ⊢ @opwith[@${e_{r}} @|ɐ| @${e_{v}}]
  : @recordτ[@repeated{@|ɐ|ᵢ : τ'ᵢ}
             @${@|ɐ| : τ_{v}}
             @${@ρf - \{@repeated{@|ɐ|'ⱼ}\}}]@;changed
  ; ϵ|⊥ ; ∅}
 #:wide 'latex
 @${@textsc{T-Record-With}_1}
 ]

TODO: removing fields on the ρ should not matter if the fields are present in
the main part of the record (as they are implicitly not in the ρ, because they
are in the main part).

@$inferrule[@${
             Γ ⊢ e_{r} : τ_{r} ; φ_{r} ; o_{r} \\
             τ_{r} <: @recordτ[@repeated{@|ɐ|ᵢ : τ'ᵢ} @ρf] \\@;changed
             Γ ⊢ e_{v} : τ_{v} ; φ_{v} ; o_{v} \\
             @|ɐ|ⱼ : τ'ⱼ ∈ @repeatset{@|ɐ|ᵢ : τ'ᵢ}
            }
            @${Γ ⊢ @opwith[@${e_{r}} @${@|ɐ|ⱼ} @${e_{v}}]
             : @recordτ[@${@repeatset{@|ɐ|ᵢ : τ'ᵢ} ∖ \{@|ɐ|ⱼ : τ'ⱼ\}}
                        @${@|ɐ|ⱼ : τ_{v}}
                        @ρf]@;changed
             ; ϵ|⊥ ; ∅}
            #:wide #t
            @${@textsc{T-Record-With}_2}]

@$inferrule[@${
             Γ ⊢ e_{r} : τ_{r} ; φ_{r} ; o_{r} \\
             τ_{r} <: @recordτ[@repeated{@|ɐ|ᵢ : τ'ᵢ} @ρf] \\
             @|ɐ|ⱼ : τ'ⱼ ∈ @repeatset{@|ɐ|ᵢ : τ'ᵢ}
            }
            @${Γ ⊢ @opwithout[@${e_{r}} @|ɐ|]
             : @recordτ[@${@repeatset{@|ɐ|ᵢ : τ'ᵢ} ∖ \{@|ɐ|ⱼ : τ'ⱼ\}}
                        @${@ρf - @|ɐ|}]
             ; ϵ|⊥ ; ∅}
            #:wide #t
            @${@textsc{T-Record-Without}}]
