ENTRY
  { 
    address
    author
    howpublished
    isbn
    journal
    month
    note
    number
    pages
    publisher
    title
    volume
    year
  }
  {}
  { label extra.label sort.label short.list }
INTEGERS { output.state before.all mid.sentence after.sentence after.block }
FUNCTION {init.state.consts}
{ #0 'before.all :=
  #1 'mid.sentence :=
  #2 'after.sentence :=
  #3 'after.block :=
}
STRINGS { s t}
FUNCTION {output.nonnull}
{ 's :=
  output.state mid.sentence =
    { ", " * write$ }
    { output.state after.block = 
        { add.period$ write$
          newline$
          "\newblock " write$
        }
        { output.state before.all =
            'write$
            { add.period$ " " * write$ }
          if$
        }
      if$
      mid.sentence 'output.state :=
    }
  if$
  s
}
FUNCTION {output.nonnull.nostate}
{ 's :=
  output.state after.block =
    { add.period$ write$
      newline$
      "\newblock " write$
    }
    'write$
  if$
  s
}
FUNCTION {output}
{ duplicate$ empty$
    'pop$
    'output.nonnull
  if$
}
FUNCTION {output.check}
{ 't :=
  duplicate$ empty$
    { pop$ "empty " t * " in " * cite$ * warning$ }
    'output.nonnull
  if$
}
INTEGERS { nameptr namesleft numnames posothers showetal}

FUNCTION {format.full.names}
{ 's :=
  #1 'nameptr :=
  s num.names$ 'numnames :=
  numnames 'namesleft :=
    { namesleft #0 > }
    { s nameptr
      "{vv~}{ll}" format.name$ 't :=
      nameptr #1 >
        { namesleft #1 >
            { ", " * t * }
            { numnames #2 >
                { "," * }
                'skip$
              if$
              t "others" =
                { " et~al. " * }
                { " and " * t * }
              if$
            }
          if$
        }
        't
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$
}

FUNCTION {create.bibitem.names }
{
  type$ "misc" =
    { author format.full.names }
    'skip$
  if$

  type$ "article" =
    { author format.full.names }
    'skip$
  if$

  type$ "book" =
    { author format.full.names }
    'skip$
  if$

}

FUNCTION {format.bibitem.first.name}
{ #1 'nameptr :=
  nameptr
  "{vv~}{ll}" format.name$
  s num.names$ #1 >
    { " et~al." * }
    'skip$
  if$
}
FUNCTION {create.bibitem.first.name}
{
  type$ "misc" =
    { author format.bibitem.first.name }
    'skip$
  if$

  type$ "article" =
    { author format.bibitem.first.name }
    'skip$
  if$

  type$ "book" =
    { author format.bibitem.first.name }
    'skip$
  if$

}

FUNCTION {create.bibitem.year}
{
  year
  "(" swap$ * ")" *
}

FUNCTION {output.bibitem}
{ newline$
  "\bibitem[" write$
  create.bibitem.first.name
  write$
  create.bibitem.year
  write$
  create.bibitem.names
  write$
  "]{" write$
  cite$ write$
  "}" write$
  newline$
  ""
  before.all 'output.state :=
}
FUNCTION {bibinfo.check}
{ swap$
  duplicate$ missing$
    {
      pop$ pop$
      ""
    }
    { duplicate$ empty$
        {
           swap$ pop$
        }
        { swap$
          pop$
        }
      if$
    }
  if$
}
FUNCTION {fin.entry}
{ add.period$
  write$
  newline$
}
FUNCTION {new.block}
{ output.state before.all =
    'skip$
    { after.block 'output.state := }
  if$
}
FUNCTION {new.sentence}
{ output.state after.block =
    'skip$
    { output.state before.all =
        'skip$
        { after.sentence 'output.state := }
      if$
    }
  if$
}
FUNCTION {add.blank}
{  " " * before.all 'output.state :=
}
FUNCTION {add.colon}
{ duplicate$ empty$
    'skip$
    { ":" * add.blank }
  if$
}
FUNCTION {not}
{   { #0 }
    { #1 }
  if$
}
FUNCTION {and}
{   'skip$
    { pop$ #0 }
  if$
}
FUNCTION {or}
{   { pop$ #1 }
    'skip$
  if$
}
FUNCTION {field.or.null}
{ duplicate$ empty$
    { pop$ "" }
    'skip$
  if$
}
FUNCTION {bolden}
{ duplicate$ empty$
    { pop$ "" }
    { "\textbf{" swap$ * "}" * }
  if$
}
FUNCTION {italize}
{ duplicate$ empty$
    { pop$ "" }
    { "\textit{" swap$ * "}" * }
  if$
}
FUNCTION {scaps}
{ duplicate$ empty$
    { pop$ "" }
    { "\textsc{" swap$ * "}" * }
  if$
}
FUNCTION {anglequote}
{ duplicate$ empty$
    { pop$ "" }
    { "<<" swap$ * ">>" * }
  if$
}
FUNCTION {singlequote}
{ duplicate$ empty$
    { pop$ "" }
    { "'{}" swap$ * "'{}" * }
  if$
}
FUNCTION {doublequote}
{ duplicate$ empty$
    { pop$ "" }
    { "``{}" swap$ * "''{}" * }
  if$
}
FUNCTION {format.names.author}
{
  's :=

  #1 'nameptr :=
  s num.names$ 'numnames :=

  numnames 'namesleft :=
  #0 'posothers :=
    { namesleft #0 > }
    { s nameptr "{ll,~}{ff}{vv}{jj}" format.name$ 't :=
      t "others" =
         { nameptr 'posothers := }
         'skip$
       if$
       nameptr #1 + 'nameptr :=
       namesleft #1 - 'namesleft :=
    }
  while$

  #0 'showetal :=

  numnames #10 >
    { #10 'numnames :=
      #1 'showetal :=
    }
    { numnames #10 =
        { posothers #0 >
          { #1 'showetal :=
            #10 'numnames :=
          }
          'skip$
         if$
         }
         { posothers #0 >
             { #1 'showetal :=
               #1 'numnames -
             }
             'skip$
           if$
         }
       if$
    }
  if$

  #1 'nameptr :=
  numnames 'namesleft :=
    { namesleft #0 > }
    { s nameptr "{ll,~}{ff}{vv}{jj}" format.name$ 't :=
      nameptr #1 >
        { namesleft #1 >
            { ", " * t * }
            { showetal #0 >
                { ", " * t * }
                { " and " * t * }
              if$
            }
          if$
        }
        't
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$

  showetal #0 >
    { " et~al." * }
    'skip$
  if$
}

FUNCTION {format.names.editor}
{
  's :=

  #1 'nameptr :=
  s num.names$ 'numnames :=

  numnames 'namesleft :=
  #0 'posothers :=
    { namesleft #0 > }
    { s nameptr "" format.name$ 't :=
      t "others" =
         { nameptr 'posothers := }
         'skip$
       if$
       nameptr #1 + 'nameptr :=
       namesleft #1 - 'namesleft :=
    }
  while$

  #0 'showetal :=

  numnames #3 >
    { #2 'numnames :=
      #1 'showetal :=
    }
    { numnames #3 =
        { posothers #0 >
          { #1 'showetal :=
            #2 'numnames :=
          }
          'skip$
         if$
         }
         { posothers #0 >
             { #1 'showetal :=
               #1 'numnames -
             }
             'skip$
           if$
         }
       if$
    }
  if$

  #1 'nameptr :=
  numnames 'namesleft :=
    { namesleft #0 > }
    { s nameptr "" format.name$ 't :=
      nameptr #1 >
        { namesleft #1 >
            { ", " * t * }
            { showetal #0 >
                { ", " * t * }
                { " and " * t * }
              if$
            }
          if$
        }
        't
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$

  showetal #0 >
    { " et~al." * }
    'skip$
  if$
}

FUNCTION {sortify}
{ purify$
  "l" change.case$
}

INTEGERS { len }


FUNCTION {chop.word}
{ 's :=
  'len :=
  s #1 len substring$ =
    { s len #1 + global.max$ substring$ }
    's
  if$
}

FUNCTION {format.title.short}
{ 't :=
  "A " #2
    "An " #3
      "The " #4 t chop.word
    chop.word
  chop.word
  #1 #3 substring$
}
FUNCTION {format.misc.author}
{ author
  duplicate$ empty$ 'skip$
    { format.names.author }
  if$
  "author" bibinfo.check
  duplicate$ empty$ 'skip$
   {
   }
  if$
}
FUNCTION {format.misc.title}
{ title
  "title" bibinfo.check
  duplicate$ empty$ 'skip$
   {
   }
  if$
}
FUNCTION {format.misc.publisher}
{ publisher
  "publisher" bibinfo.check
  duplicate$ empty$ 'skip$
   {
     italize
   }
  if$
}
FUNCTION {format.misc.year}
{ year
  "year" bibinfo.check
  duplicate$ empty$ 'skip$
   {
   }
  if$
}
FUNCTION {format.misc.note}
{ note
  "note" bibinfo.check
  duplicate$ empty$ 'skip$
   {
   }
  if$
}
FUNCTION {format.misc.howpublished}
{ howpublished
  "howpublished" bibinfo.check
  duplicate$ empty$ 'skip$
   {
   }
  if$
}
FUNCTION {misc}
{ output.bibitem
  author empty$
  'skip$
    {         format.misc.author
       output.nonnull.nostate
       ".~"
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate    }
  if$
  new.block
  title empty$
  'skip$
    {         format.misc.title
       output.nonnull.nostate
       ".~"
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate    }
  if$
  new.block
  publisher empty$
  'skip$
    {  "In~"
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate       format.misc.publisher
       output.nonnull.nostate
       "~[interaktyvus].~"
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate    }
  if$
  new.block
  year empty$
  'skip$
    {         format.misc.year
       output.nonnull.nostate
       ",~"
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate    }
  if$
  new.block
  note empty$
  'skip$
    {  "~[\v{z}i\={u}r\.{e}ta~"
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate       format.misc.note
       output.nonnull.nostate
       "].~"
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate    }
  if$
  new.block
  howpublished empty$
  'skip$
    {  "Prieiga per internet{\k a}: ~<"
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate       format.misc.howpublished
       output.nonnull.nostate
       ">"
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate    }
  if$
  new.block
  fin.entry
}
FUNCTION {format.article.author}
{ author
  duplicate$ empty$ 'skip$
    { format.names.author }
  if$
  "author" bibinfo.check
  duplicate$ empty$ 'skip$
   {
   }
  if$
}
FUNCTION {format.article.title}
{ title
  "title" bibinfo.check
  duplicate$ empty$ 'skip$
   {
   }
  if$
}
FUNCTION {format.article.journal}
{ journal
  "journal" bibinfo.check
  duplicate$ empty$ 'skip$
   {
     italize
   }
  if$
}
FUNCTION {format.article.month}
{ month
  "month" bibinfo.check
  duplicate$ empty$ 'skip$
   {
   }
  if$
}
FUNCTION {format.article.year}
{ year
  "year" bibinfo.check
  duplicate$ empty$ 'skip$
   {
   }
  if$
}
FUNCTION {format.article.volume}
{ volume
  "volume" bibinfo.check
  duplicate$ empty$ 'skip$
   {
   }
  if$
}
FUNCTION {format.article.number}
{ number
  "number" bibinfo.check
  duplicate$ empty$ 'skip$
   {
   }
  if$
}
FUNCTION {format.article.pages}
{ pages
  "pages" bibinfo.check
  duplicate$ empty$ 'skip$
   {
   }
  if$
}
FUNCTION {article}
{ output.bibitem
  author empty$
  'skip$
    {         format.article.author
       output.nonnull.nostate
       ".~"
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate    }
  if$
  new.block
  title empty$
  'skip$
    {         format.article.title
       output.nonnull.nostate
       ".~"
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate    }
  if$
  new.block
  journal empty$
  'skip$
    {  "In~"
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate       format.article.journal
       output.nonnull.nostate
       ",~"
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate    }
  if$
  new.block
  month empty$
  'skip$
    {         format.article.month
       output.nonnull.nostate
       "~"
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate    }
  if$
  new.block
  year empty$
  'skip$
    {         format.article.year
       output.nonnull.nostate
       ",~"
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate    }
  if$
  new.block
  volume empty$
  'skip$
    {  "vol.~"
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate       format.article.volume
       output.nonnull.nostate
       ",~"
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate    }
  if$
  new.block
  number empty$
  'skip$
    {  "no.~"
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate       format.article.number
       output.nonnull.nostate
       ",~"
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate    }
  if$
  new.block
  pages empty$
  'skip$
    {  "p.~"
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate       format.article.pages
       output.nonnull.nostate
    }
  if$
  new.block
  fin.entry
}
FUNCTION {format.book.author}
{ author
  duplicate$ empty$ 'skip$
    { format.names.author }
  if$
  "author" bibinfo.check
  duplicate$ empty$ 'skip$
   {
   }
  if$
}
FUNCTION {format.book.title}
{ title
  "title" bibinfo.check
  duplicate$ empty$ 'skip$
   {
     italize
   }
  if$
}
FUNCTION {format.book.address}
{ address
  "address" bibinfo.check
  duplicate$ empty$ 'skip$
   {
   }
  if$
}
FUNCTION {format.book.publisher}
{ publisher
  "publisher" bibinfo.check
  duplicate$ empty$ 'skip$
   {
   }
  if$
}
FUNCTION {format.book.year}
{ year
  "year" bibinfo.check
  duplicate$ empty$ 'skip$
   {
   }
  if$
}
FUNCTION {format.book.pages}
{ pages
  "pages" bibinfo.check
  duplicate$ empty$ 'skip$
   {
   }
  if$
}
FUNCTION {format.book.isbn}
{ isbn
  "isbn" bibinfo.check
  duplicate$ empty$ 'skip$
   {
   }
  if$
}
FUNCTION {book}
{ output.bibitem
  author empty$
  'skip$
    {         format.book.author
       output.nonnull.nostate
       ".~"
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate    }
  if$
  new.block
  title empty$
  'skip$
    {         format.book.title
       output.nonnull.nostate
       ".~"
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate    }
  if$
  new.block
  address empty$
  'skip$
    {         format.book.address
       output.nonnull.nostate
       ":~"
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate    }
  if$
  new.block
  publisher empty$
  'skip$
    {         format.book.publisher
       output.nonnull.nostate
    }
  if$
  new.block
  year empty$
  'skip$
    {  ",~"
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate       format.book.year
       output.nonnull.nostate
       ".~"
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate    }
  if$
  new.block
  pages empty$
  'skip$
    {         format.book.pages
       output.nonnull.nostate
       "~p.~"
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate    }
  if$
  new.block
  isbn empty$
  'skip$
    {  "ISBN~"
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate       format.book.isbn
       output.nonnull.nostate
    }
  if$
  new.block
  fin.entry
}
READ
FUNCTION {sort.format.names}
{ 's :=
  #1 'nameptr :=
  ""
  s num.names$ 'numnames :=
  numnames 'namesleft :=
    { namesleft #0 > }
    { nameptr #1 >
        { "   " * }
        'skip$
      if$
      s nameptr "{vv{ } }{ll{ }}{  f{ }}{  jj{ }}" format.name$ 't :=
      nameptr numnames = t "others" = and
        { "et al" *}
        { t sortify * }
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$
}
FUNCTION {sort.format.title}
{ 't :=
  "A " #2
    "An " #3
      "The " #4 t chop.word
    chop.word
  chop.word
  sortify
  #1 global.max$ substring$
}
FUNCTION {author.title.publisher.year.note.howpublished.sort}
{ author empty$
    { title empty$
        { publisher empty$
            { year empty$
                { note empty$
                    { howpublished empty$
                        { "to sort, need author, title, publisher, year, note, orhowpublished in " cite$ * warning$
  ""
}
                        {howpublished format.title.short sortify }                      if$
                    }
                    {note format.title.short sortify }                  if$
                }
                {year format.title.short sortify }              if$
            }
            {publisher format.title.short sortify }          if$
        }
        {title format.title.short sortify }      if$
    }
    { author sort.format.names }
  if$
}
FUNCTION {author.title.journal.month.year.volume.number.pages.sort}
{ author empty$
    { title empty$
        { journal empty$
            { month empty$
                { year empty$
                    { volume empty$
                        { number empty$
                            { pages empty$
                                { "to sort, need author, title, journal, month, year, volume, number, orpages in " cite$ * warning$
  ""
}
                                {pages format.title.short sortify }                              if$
                            }
                            {number format.title.short sortify }                          if$
                        }
                        {volume format.title.short sortify }                      if$
                    }
                    {year format.title.short sortify }                  if$
                }
                {month format.title.short sortify }              if$
            }
            {journal format.title.short sortify }          if$
        }
        {title format.title.short sortify }      if$
    }
    { author sort.format.names }
  if$
}
FUNCTION {author.title.address.publisher.year.pages.isbn.sort}
{ author empty$
    { title empty$
        { address empty$
            { publisher empty$
                { year empty$
                    { pages empty$
                        { isbn empty$
                            { "to sort, need author, title, address, publisher, year, pages, orisbn in " cite$ * warning$
  ""
}
                            {isbn format.title.short sortify }                          if$
                        }
                        {pages format.title.short sortify }                      if$
                    }
                    {year format.title.short sortify }                  if$
                }
                {publisher format.title.short sortify }              if$
            }
            {address format.title.short sortify }          if$
        }
        {title format.title.short sortify }      if$
    }
    { author sort.format.names }
  if$
}
FUNCTION {presort}
{  type$ "misc" =
    'author.title.publisher.year.note.howpublished.sort
    'skip$
  if$
  type$ "article" =
    'author.title.journal.month.year.volume.number.pages.sort
    'skip$
  if$
  type$ "book" =
    'author.title.address.publisher.year.pages.isbn.sort
    'skip$
  if$
  "    "
  *
  year field.or.null sortify
  *
  "    "
  *
  title field.or.null
  sort.format.title
  *
  #1 entry.max$ substring$
  'sort.key$ :=
}

ITERATE {presort}

SORT

STRINGS { longest.label last.label next.extra }

INTEGERS { longest.label.width last.extra.num number.label }

FUNCTION { initialize.longest.label }
{ "" 'longest.label :=
  #0 int.to.chr$ 'last.label :=
  "" 'next.extra :=
  #0 'longest.label.width :=
  #0 'last.extra.num :=
  #0 'number.label :=
}

FUNCTION {forward.pass}
{ last.label label =
    { last.extra.num #1 + 'last.extra.num :=
      last.extra.num int.to.chr$ 'extra.label :=
    }
    { "a" chr.to.int$ 'last.extra.num :=
      "" 'extra.label :=
      label 'last.label :=
    }
  if$
  number.label #1 + 'number.label :=
}

FUNCTION {reverse.pass}
{ next.extra "b" =
    { "a" 'extra.label := }
    'skip$
  if$
  extra.label 'next.extra :=
  extra.label
  duplicate$ empty$
    'skip$
    { "{\natexlab{" swap$ * "}}" * }
  if$
  'extra.label :=
  label extra.label * 'label :=
}

EXECUTE {initialize.longest.label}

ITERATE {forward.pass}

REVERSE {reverse.pass}

FUNCTION {begin.bib}
{ preamble$ empty$
    'skip$
    { preamble$ write$ newline$ }
  if$
  "\begin{thebibliography}{"  number.label int.to.str$  * "}" * write$ newline$
  "\providecommand{\natexlab}[1]{#1}" write$ newline$
}
EXECUTE {begin.bib}
EXECUTE {init.state.consts}
ITERATE {call.type$}
FUNCTION {end.bib}
{ newline$
  "\end{thebibliography}" write$ newline$
}EXECUTE {end.bib}