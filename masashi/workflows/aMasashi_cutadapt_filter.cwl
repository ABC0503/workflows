cwlVersion: v1.0
class: Workflow


inputs:

    input_fastq:
      type: File
    m__:
      type: int?
    u__:
      type: int?
    a__:
      type: string?
    b__:
      type:
        - "null"
        - type: array
          items: string

    q__:
      type: int?
    p__:
      type: int?
    Q33__:
      type: boolean?


outputs:
  trimmsed:
    type: File
    outputSource: cutadapt/Trimmed_file

  filterred:
    type: File
    outputSource: fastq_quality_filter/filterred_file


steps:
  cutadapt:
    run: ../tools/aMasashi_Cutadapt.cwl
    in:
      m: m__
      u: u__
      a: a__
      b: b__
      input_fastq: input_fastq
    out: [Trimmed_file]

  fastq_quality_filter:
    run: ../tools/aMasashi_fastq_quality_filter.cwl
    in:
        q: q__
        p: p__
        Q33: Q33__
        fastq: cutadapt/Trimmed_file
    out: [filterred_file]
