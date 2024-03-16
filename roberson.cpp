int main() {
    int X[4];
    int Y[4];

    A = 0000;
    Q = X;

    M = Y;

    count = 0;
    F = 0;

    while (count < 3) {
        A = A + M*Q[0];     // addizione
        F = M[3];           // flip-flop
        Q[2:0] = Q[3:1];    // shift
        Q[3] = A[0];
        A[2:0] = A[3:1];
        A[3] = F;           // fine shift;
        count++;
    }  

    F = F xor Q[0];
    A = A - M*Q[0];
    Q[2:0] = Q[3:1];    // shift
    Q[3] = A[0];
    A[2:0] = A[3:1];
    A[3] = F;

    output = A merge Q;

}