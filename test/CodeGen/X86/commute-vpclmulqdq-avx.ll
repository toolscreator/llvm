; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown -mattr=+vpclmulqdq | FileCheck %s
; FIXME: actual vpclmulqdq operation should be eliminated

declare <4 x i64> @llvm.x86.pclmulqdq.256(<4 x i64>, <4 x i64>, i8) nounwind readnone

define <4 x i64> @commute_v1(<4 x i64> %a0, <4 x i64> %a1) {
; CHECK-LABEL: commute_v1:
; CHECK:       # BB#0:
; CHECK-NEXT:    vpclmulqdq $0, %ymm1, %ymm0, %ymm0
; CHECK-NEXT:    vxorps %ymm0, %ymm0, %ymm0
; CHECK-NEXT:    retq
  %1 = call <4 x i64> @llvm.x86.pclmulqdq.256(<4 x i64> %a0, <4 x i64> %a1, i8 0)
  %2 = call <4 x i64> @llvm.x86.pclmulqdq.256(<4 x i64> %a1, <4 x i64> %a0, i8 0)
  %3 = xor <4 x i64> %1, %2
  ret <4 x i64> %3
}

define <4 x i64> @commute_v2(<4 x i64> %a0, <4 x i64> %a1) {
; CHECK-LABEL: commute_v2:
; CHECK:       # BB#0:
; CHECK-NEXT:    vpclmulqdq $16, %ymm1, %ymm0, %ymm0
; CHECK-NEXT:    vxorps %ymm0, %ymm0, %ymm0
; CHECK-NEXT:    retq
  %1 = call <4 x i64> @llvm.x86.pclmulqdq.256(<4 x i64> %a0, <4 x i64> %a1, i8 16)
  %2 = call <4 x i64> @llvm.x86.pclmulqdq.256(<4 x i64> %a1, <4 x i64> %a0, i8 1)
  %3 = xor <4 x i64> %2, %1
  ret <4 x i64> %3
}

define <4 x i64> @commute_v3(<4 x i64> %a0, <4 x i64> %a1) {
; CHECK-LABEL: commute_v3:
; CHECK:       # BB#0:
; CHECK-NEXT:    vpclmulqdq $17, %ymm1, %ymm0, %ymm0
; CHECK-NEXT:    vxorps %ymm0, %ymm0, %ymm0
; CHECK-NEXT:    retq
  %1 = call <4 x i64> @llvm.x86.pclmulqdq.256(<4 x i64> %a0, <4 x i64> %a1, i8 17)
  %2 = call <4 x i64> @llvm.x86.pclmulqdq.256(<4 x i64> %a1, <4 x i64> %a0, i8 17)
  %3 = xor <4 x i64> %2, %1
  ret <4 x i64> %3
}
