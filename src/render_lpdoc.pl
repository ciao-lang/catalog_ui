:- module(_, [], [assertions, dcg, fsyntax]).

% From `docfile` (a .pl module, .lpdoc, or .md file containing
% documentation) to a HTML term. If translation fails, emits a
% verbatim text view.

:- use_module(library(pathnames)).
:- use_module(library(system), [file_exists/1]).
:- use_module(library(stream_utils), [file_to_string/2]).

:- use_module(library(persdb/datadir), [ensure_datadir/2]).
:- use_module(lpdoc(lpdoc_single_mod), [docfile_to_html_term/2]).

:- export(render_docfile/2).
% Render as HTML a documentation file (single file)
% (supports .lpdoc, .md)
render_docfile(File) := HtmlTerm :-
    \+ is_plain_text(File),
    catch(docfile_to_html_term(File, HtmlTerm0), _, fail),
    !,
    HtmlTerm = HtmlTerm0.
render_docfile(File) := ~render_txt(File) :- file_exists(File), !.
render_docfile(_File) := ['[File not found]'].

render_txt(File) := R :-
    file_to_string(File, Content),
    R = env(pre, [], [verbatim(Content)]).

is_plain_text(R) :-
    % No extension, assume plain text
    path_splitext(R, _, '').

