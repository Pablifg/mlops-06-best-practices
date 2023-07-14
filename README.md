# mlops-06-best-practices
### Goal: 
Take the ride duration prediction model that we deployed in batch mode in homework 4 and improve the reliability of our code with unit and integration tests.

### Learnings:
PART A
- Testing Python code with pytest
- Integration test with docker-compose
- Testing cloud services with localstack package
- Lintinh and formating the code
- Use git pre-commit hooks
- Makefiles and make

PART B: INFRASTRUCTURE AS CODE
- Configuration and use of Terraform
- Test pipeline e2e
- CI/CD with GitHub Actions


```bash
docker build -t bash-model-duration:v1 .
```