cwlVersion: v1.0
class: CommandLineTool
doc: removing adaptor by cutadapt

requirements:
- class: InlineJavascriptRequirement
- class: ShellCommandRequirement

baseCommand: cutadapt

hints:
- class: DockerRequirement
  dockerPull: genomicpariscentre/cutadapt:1.8.3


inputs:

  m:
    type: int?
    doc: |
      Discard reads shorter than LEN
    inputBinding:
      position: 0
      prefix: '-m'

  u:
    type:
    - "null"
    - int
    doc: |
     DiscardRemove bases from each read
    inputBinding:
      position: 1
      prefix: '-u'

  a:
    type: string?
    doc: |
     Sequence of an adapter ligated to the 3' end
    inputBinding:
      position: 2
      prefix: '-a'

  b:
    type:
      - "null"
      - type: array
        items: string
    doc: |
     Sequence of an adapter that may be ligated to the 5'or 3' end. can put some adaptor sequences.
    inputBinding:
      position: 3
      prefix: '-b'
      itemSeparator: " -b "
      shellQuote: False


  input_fastq:
    type: File
    doc: |
         input file must be .fastq or .fastq.bz2
    inputBinding:
      position: 4


outputs:
  trimmed_file:
    type: stdout

stdout: Adaptor_Trimed.fastq
