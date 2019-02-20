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

    fasta:
      type: File


outputs:
  trimmed:
    type: File
    outputSource: cutadapt/trimmed_file

  filtered:
    type: File
    outputSource: trimmomatic/upstream_trimmed_file

#
  # mapping_bam:
  #   type: File
  #   outputSource: bowtie/mapping_sam


steps:
  cutadapt:
    run: ../tools/aMasashi_Cutadapt.cwl
    in:
      m: m__
      u: u__
      a: a__
      b: b__
      input_fastq: input_fastq
    out: [trimmed_file]

  trimmomatic:
    run: ../tools/trimmomatic.cwl
    in:
      minlen_step:
        default: 15
      trailing_step:
        default: 20
      sliding_window_step:
        default: "4:15"
      fastq_file_upstream: cutadapt/trimmed_file
      adapters_file: fasta
      lib_type:
        default: "SE"
      illuminaclip_step_param:
        default: "2:30:15"
      trigger:
        default: true

    out: [upstream_trimmed_file]

  # bowtie:
  #   run: ../tools/bowtie-alignreads.cwl
  #   in:
  #       indices_folder: indices_folder
  #       downstream_filelist: downstream_filelist
  #       threads: 1,
  #       un: "unaligned.txt",
  #       al: "aligned.txt",
  #       max: "multimapped.txt",
  #       refout: true
  #       output_filename: "result.txt"
  #       m: 1
  #       v: 2
  #       a: true
  #       best: true
  #       strata: true
  #
  #   out: [mapping_sam]
  #
  # # samtools_view:
  #   run: ../tools/samtools-view.cwl
  #   in:
  #   out: [mapping_bam]
  #
  # samtools_sort:
  #   run: ../tools/samtools-sort.cwl
  #   in:
  #   out: [sorted_bam]
  #
  # samtools_view:
  #   run: ../tools/samtools-view.cwl
  #   in:
  #   out: [mapped_bam]
  #
  # samtools_idxstats:
  #   run: ../tools/aMasashi_samtools-idxstats.cwl
  #   in:
  #   out: [Read_count]
