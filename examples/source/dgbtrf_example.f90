    Program dgbtrf_example

!     DGBTRF Example Program Text

!     Copyright (c) 2018, Numerical Algorithms Group (NAG Ltd.)
!     For licence see
!       https://github.com/numericalalgorithmsgroup/LAPACK_Examples/blob/master/LICENCE.md

!     .. Use Statements ..
      Use lapack_example_aux, Only: nagf_file_print_matrix_real_band
      Use lapack_interfaces, Only: dgbtrf
      Use lapack_precision, Only: dp
!     .. Implicit None Statement ..
      Implicit None
!     .. Parameters ..
      Integer, Parameter :: nin = 5, nout = 6
!     .. Local Scalars ..
      Integer :: i, ifail, info, j, k, kl, ku, ldab, m, n
!     .. Local Arrays ..
      Real (Kind=dp), Allocatable :: ab(:, :)
      Integer, Allocatable :: ipiv(:)
!     .. Intrinsic Procedures ..
      Intrinsic :: max, min
!     .. Executable Statements ..
      Write (nout, *) 'DGBTRF Example Program Results'
!     Skip heading in data file
      Read (nin, *)
      Read (nin, *) m, n, kl, ku
      ldab = 2*kl + ku + 1
      Allocate (ab(ldab,n), ipiv(n))

!     Read A from data file

      k = kl + ku + 1
      Read (nin, *)((ab(k+i-j,j),j=max(i-kl,1),min(i+ku,n)), i=1, m)

!     Factorize A
      Call dgbtrf(m, n, kl, ku, ab, ldab, ipiv, info)

!     Print details of factorization

      Write (nout, *)
      Flush (nout)

!     ifail: behaviour on error exit
!             =0 for hard exit, =1 for quiet-soft, =-1 for noisy-soft
      ifail = 0
      Call nagf_file_print_matrix_real_band(m, n, kl, kl+ku, ab, ldab, &
        'Details of factorization', ifail)

!     Print pivot indices

      Write (nout, *)
      Write (nout, *) 'IPIV'
      Write (nout, 100) ipiv(1:min(m,n))

      If (info/=0) Then
        Write (nout, *) 'The factor U is singular'
      End If

100   Format ((3X,7I11))
    End Program
