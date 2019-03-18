# start from an official image
FROM python:3.6

# arbitrary location choice: you can change the directory
RUN mkdir -p /opt/services/djangoapp/src
WORKDIR /opt/services/djangoapp/src

# install our dependencies
# we use --system flag because we don't need an extra virtualenv
COPY Pipfile Pipfile.lock /opt/services/djangoapp/src/
RUN pip install pipenv && pipenv install --system



# install our two dependencies
# RUN pip install gunicorn django

# copy our project code
COPY . /opt/services/djangoapp/src

# expose the port 4000
EXPOSE 4000

# define the default command to run when starting the container
CMD ["gunicorn", "--chdir", "hello", "--bind", ":4000", "hello.wsgi:application"]

