.\"-----------------
.de R
.ie \\n(.$=0 .ft R
.el \\fR\\$1\\fP\\$2
..
.\"-----------------
.de I
.ie \\n(.$=0 .ft I
.el \\fI\\$1\\fP\\$2
..
.\"-----------------
.de B
.ie \\n(.$=0 .ft B
.el \\fB\\$1\\fP\\$2
..
.\"-----------------
.de UX
.\" old-fashioned capitalization -- I've never gotten used to the new one
\\$2Unix\\$1
..
.\"-----------------
.de DA
.ds DY "\\$1 \\$2 \\$3
.\" keep trailing spaces out of CF
.if \\n(.$=1 .ds CF "\\$1
.if \\n(.$=2 .ds CF "\\$1 \\$2
.if \\n(.$>2 .ds CF "\\$1 \\$2 \\$3
..
.\"-----------------
.de ND
.\" it's our default, ignore it
..
.\"-----------------
.de TL
.rs
.sp 5
.ft B
.ce 9999
..
.\"-----------------
.de AU
.sp 2
.ft R
..
.\"-----------------
.de AI
.sp
.ft R
..
.\"-----------------
.de AB
.sp 2
.ce 0
.ll -7n
.in +7n
..
.\"-----------------
.de AE
.sp
.ll
.in
..
.\"-----------------
.\" common initialization for headers and paragraphs:  .In need extraspace
.de In
.ne \\$1
.sp \\n(Tsu
.nr Ts 0
.ie \\n(.$>1 .nr iN \\$2v
.el .nr iN 0
.sp \\n(PDu+\\n(iNu
.ce 0
.ft R
.in \\n(inu
.ll \\n(LLu
.ns
.fi
.ti 0
..
.\"-----------------
.de SH
.nr in 0
.In 6 1
.ft B
..
.\"-----------------
.de NH
.nr in 0
.In 6 1
.ft B
.\" punt to awk code to get the header numbering right
.nH \\$1
.\" and pick up the result
\&\\*(Nh
..
.\"-----------------
.de LP
.In 4
..
.\"-----------------
.de PP
.In 4
.ti \\n(PIu
..
.\"-----------------
.de TP
.In 4
.if \\n(.$>0 .nr tp \\$1n
.in \\n(inu+\\n(tpu
.ti 0-\\n(tpu
.it 1 tP
..
.\"-----------------
.de IP
.ie \\n(.$>1 .TP "\\$2"
.el .TP
\&\\$1
..
.\"-----------------
.de QP
.In 4
.in +5n
.ll -5n
..
.\"-----------------
.de QS
.nr in +5n
.nr LL -5n
.In 4
..
.\"-----------------
.de QE
.nr in -5n
.nr LL +5n
.In 4
..
.\"-----------------
.de DS
.In 5
.if '\\$1'C' .ce 9999
.if '\\$1'' .in +5n
.nf
..
.\"-----------------
.de CD
.In 5
.ce 9999
.nf
..
.\"-----------------
.de LD
.In 5
.nf
..
.\"-----------------
.de ID
.In 5
.in +5n
.nf
..
.\"-----------------
.de DE
.In 3
.rs
..
.\"-----------------
.de RS
.nr in +5n
.in \\n(inu
..
.\"-----------------
.de RE
.nr in -5n
.in \\n(inu
..
.\"-----------------
.de UL
\&\\fI$1\\fP
..
.\"-----------------
.de RP
..
.\"-----------------
.de LG
..
.\"-----------------
.de SM
..
.\"-----------------
.de NL
..
.\"-----------------
.de CP
.bp
.SH 1
\\$1
..
.\"-----------------
.de FS
^{
..
.de FE
}
..
.\"-----------------
.de UR
(\\$2)[\\$1]
..
.de post.mark
..
.\"-----------------
.\" the -ms accent strings
.ds ' "'\b
.ds ` "`\b
.ds : ":\b
.ds ^ "^\b
.ds ~ "~\b
.ds C "v\b
.ds , ",\b
.\" post-title spacing
.nr Ts 4v
.\" and parameter setup
.nr LL 72m
.ll \n(LLu
.nr PD 0.3v
.nr PI 5n
.nr tp 5n
